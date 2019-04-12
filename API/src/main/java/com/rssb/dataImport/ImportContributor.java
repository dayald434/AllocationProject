package com.rssb.dataImport;

import com.google.common.base.Strings;
import com.rssb.api.helper.StaticContent;
import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.City;
import com.rssb.common.entity.Preacher;
import org.apache.commons.lang.WordUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class ImportContributor {

    public static List<String > importCon(String path) throws Exception {

        HashSet<String> set = new HashSet<>();
        List<String> dup = new ArrayList<>();

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-YYYY");

        FileInputStream file = new FileInputStream(new File(path));

        XSSFWorkbook workbook = new XSSFWorkbook(file);

        XSSFSheet sheet = workbook.getSheetAt(0);

        List<String > issues= new ArrayList<>();


        //Iterate through each rows one by one
        Iterator<Row> rowIterator = sheet.iterator();
        rowIterator.next();
        ApiHelper apiHelper = new ApiHelper();
        int rownum=1;
        while (rowIterator.hasNext()) {
            ++rownum;
            Row row = rowIterator.next();
            int k = 0;

            String sgName = getStringOrNull(row.getCell(k++));
            if (Strings.isNullOrEmpty(sgName)) {
                issues.add("ROW No"+rownum+ "SG name ");
                continue;
            }

            String name = row.getCell(k++).toString().trim();
            name = WordUtils.capitalize(name.toLowerCase());

            if (Strings.isNullOrEmpty(name)) {
                issues.add("ROW No"+rownum+ "Name ");
                continue;
            }
            Cell cellSN = row.getCell(k++);
            String shortName = null;
            if (cellSN != null)
                shortName = cellSN.toString().trim().toUpperCase();
            else {
                issues.add("ROW No"+rownum+ "Short name null");
                continue;
            }

            if (Strings.isNullOrEmpty(shortName)) {
                issues.add("ROW No"+rownum+ "SG name null or empty ");
                continue;
            }

            Date dob = getDate(row.getCell(k++));
            Date iniDate = getDate(row.getCell(k++));
            System.out.println("++++++++++++++" + iniDate);

            String type = row.getCell(k++).toString().trim();
            String sex = row.getCell(k++).toString().trim();
            Long mobile1 = (long) getLong(row.getCell(k++));
            Long mobile2 = (long) getLong(row.getCell(k++));

            if (mobile1 == 0)
                mobile1 = 1234567890l;
            if (mobile2 == 0)
                mobile2 = null;

            String lang1 = getString(row.getCell(k++));
            String lang2 = getString(row.getCell(k++));
            String lang3 = getString(row.getCell(k++));
            String lang4 = getString(row.getCell(k++));
            String tp = getString(row.getCell(k++));

            tp = Strings.isNullOrEmpty(tp) ? "TP1" : tp.toUpperCase();

            String cityName = getStringOrNull(row.getCell(k++));
            String avail = getStringOrNull(row.getCell(k++));

            String lang[] = {lang1, lang2, lang3, lang4};

            String initDateStr = "01-Jan-1810";
            if (iniDate != null) {
                initDateStr = dateFormat.format(iniDate);
            }

            String dobStr = null;
            if (dob != null) {
                dobStr = dateFormat.format(dob);
            }

            City city = StaticContent.getCityObjectFromName(cityName);

            System.out.println(tp);

            if (set.contains(shortName)) {
                dup.add(shortName);
                issues.add("Row: "+rownum+ "Duplicate ShortName: "+shortName);

                System.out.println("----------------------------++++++++" + shortName + "+++++++++++++++-----------------------");
            }
            set.add(shortName);

            Preacher preacherRow = Preacher.builder()
                    .sgName(sgName)
                    .name(name)
                    .shortName(shortName.trim().toUpperCase())
                    .dob(dobStr)
                    .iniDate(initDateStr)
                    .type(type)
                    .sex(sex)
                    .mobile1(mobile1)
                    .mobile2(mobile2)
                    .tp(tp)
                    .city(city.getCode())
                    .lang(lang)
                    .availableDays(getAvailArray(avail))
                    .build();

            Map<String, String> contMap = apiHelper.getShortNameMap();
            Map<String, Long> sgNameMap = apiHelper.getSgNameMap();

            Long sgId = sgNameMap.get(sgName.toLowerCase());
            preacherRow.setSgId(sgId);

            if (!Strings.isNullOrEmpty(preacherRow.getShortName())) {

                if (contMap.get(preacherRow.getShortName()) == null) {
                    apiHelper.addPreacher(preacherRow);
                } else {
                    apiHelper.updatePreacher(preacherRow, preacherRow.getShortName());
                }
            }

            System.out.println(preacherRow);
        }
        file.close();
        System.out.println("-------------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-------------------");
        System.out.println(dup);
        System.out.println("-------------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-------------------");
        return issues;
    }

    private static String[] getAvailArray(String avail) {
        String[] defaultAvailArray = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
        if (Strings.isNullOrEmpty(avail))
            return defaultAvailArray;
        String[] array = avail.split(",");
        String[] array2 = new String[array.length];

        for (int i = 0; i < array.length; i++) {
            array2[i] = WordUtils.capitalize(array[i].toLowerCase());
        }
        return array2;
    }

    private static String getString(Cell cell) {
        if (cell == null)
            return "";
        return cell.toString().trim();
    }

    private static String getStringOrNull(Cell cell) {
        if (cell == null)
            return null;

        try {
            return cell.toString().trim();
        } catch (Exception e) {

        }
        return null;
    }

    private static double getLong(Cell cell) {
        if (cell == null)
            return 0;

        try {
            return cell.getNumericCellValue();
        } catch (Exception e) {

        }
        return 0;
    }

    private static Date getDate(Cell cell) {
        System.out.println(cell);
        if (cell == null)
            return null;

        try {
            return cell.getDateCellValue();
        } catch (Exception e) {

        }
        return null;
    }
}

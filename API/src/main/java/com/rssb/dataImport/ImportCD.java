package com.rssb.dataImport;

import com.google.common.base.Strings;
import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.CD;
import org.apache.commons.lang.WordUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class ImportCD {

    public static List<String> importCon(String path) throws Exception {

        FileInputStream file = new FileInputStream(new File(path));

        XSSFWorkbook workbook = new XSSFWorkbook(file);

        XSSFSheet sheet = workbook.getSheetAt(0);

        List<String> issues = new ArrayList<>();

        //Iterate through each rows one by one
        Iterator<Row> rowIterator = sheet.iterator();
        rowIterator.next();
        ApiHelper apiHelper = new ApiHelper();
        int rownum = 1;
        while (rowIterator.hasNext()) {
            ++rownum;
            Row row = rowIterator.next();
            int k = 0;

            String id = getStringOrNull(row.getCell(k++));
            if (Strings.isNullOrEmpty(id)) {
                issues.add("ROW No" + rownum + "ID ");
                continue;
            }

            String desc1 = getStringOrNull(row.getCell(k++));
            if (Strings.isNullOrEmpty(desc1)) {
                issues.add("ROW No" + rownum + "Desc1 ");
                continue;
            }

            String desc2 = getStringOrNull(row.getCell(k++));

            CD cd = CD.builder().id(id).desc1(desc1).desc2(desc2).build();
            apiHelper.addCD(cd);
        }
        file.close();
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

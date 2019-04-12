package com.rssb.dataImport;

import com.google.common.base.Strings;
import com.rssb.api.helper.StaticContent;
import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.City;
import org.apache.commons.lang.WordUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;

public class ImportCities {

    public static void importCities(String path) throws Exception {

        int i = 0;

        ApiHelper apiHelper = new ApiHelper();

        FileInputStream file = new FileInputStream(new File(path));
        XSSFWorkbook workbook = new XSSFWorkbook(file);
        XSSFSheet sheet = workbook.getSheetAt(2);
        Iterator<Row> rowIterator = sheet.iterator();
        rowIterator.next();
        while (rowIterator.hasNext()) {

            System.out.println("------------------" + i + "------------------------------");

            Row row = rowIterator.next();

            int k = 0;

            String cityName = getString(row.getCell(k++));
            if (Strings.isNullOrEmpty(cityName)) {
                System.out.println("---skipping1---");
                continue;
            }
            String cityCode = getString(row.getCell(k++));
            if (Strings.isNullOrEmpty(cityCode)) {
                System.out.println("---skipping2---");
                continue;
            }
            ;

            String stateName = getString(row.getCell(k++));
            if (Strings.isNullOrEmpty(stateName)) {
                System.out.println("---skipping3---");
                continue;
            }
            ;

            String sc = StaticContent.stateNameToStateCode.get(stateName.toUpperCase());
            if (sc == null) {
                System.out.println("---skipping4---");
                continue;
            }
            ;

            System.out.println(cityName);
            System.out.println(WordUtils.capitalize(cityName.toLowerCase()));
            System.out.println(cityName);

            City city = City.builder().name(WordUtils.capitalize(cityName.toLowerCase())).code(cityCode.toUpperCase()).stateName(stateName).stateCode(sc).build();

            apiHelper.addCity(city);
            ++i;
        }
        file.close();

        System.out.println(i);
    }

    private static String getString(Cell cell) {
        if (cell == null)
            return "";
        return cell.toString().trim();
    }
}


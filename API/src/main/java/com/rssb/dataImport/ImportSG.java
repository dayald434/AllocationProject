package com.rssb.dataImport;

import com.google.common.base.Strings;
import com.rssb.api.helper.StaticContent;
import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.City;
import com.rssb.common.entity.SatsangGhar;
import com.rssb.common.entity.Schedule;
import org.apache.commons.lang.WordUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class ImportSG {

    public static void importSG(String path) throws Exception {

        int i = 0;

        ApiHelper apiHelper = new ApiHelper();

        FileInputStream file = new FileInputStream(new File(path));
        XSSFWorkbook workbook = new XSSFWorkbook(file);
        XSSFSheet sheet = workbook.getSheetAt(1);
        Iterator<Row> rowIterator = sheet.iterator();
        rowIterator.next();
        while (rowIterator.hasNext()) {

            System.out.println("------------------" + i + "------------------------------");

            Row row = rowIterator.next();

            int k = 0;

            String name = getString(row.getCell(k++));
            if (Strings.isNullOrEmpty(name))
                continue;
            String type = getString(row.getCell(k++));
            String parentCenter = getString(row.getCell(k++));
            String addr1 = getString(row.getCell(k++));
            String addr2 = getString(row.getCell(k++));
            String cityName = getString(row.getCell(k++));
            String state = getString(row.getCell(k++));

            Long pinCode = (long) getLong(row.getCell(k++));

            Long mobile1 = (long) getLong(row.getCell(k++));
            Long mobile2 = (long) getLong(row.getCell(k++));
            Long landline1 = (long) getLong(row.getCell(k++));
            Long landline2 = (long) getLong(row.getCell(k++));
            String secName = getString(row.getCell(k++));
            Long secMobile = (long) getLong(row.getCell(k++));

            String sunData = getString(row.getCell(k++));
            String monData = getString(row.getCell(k++));
            String tueData = getString(row.getCell(k++));
            String wedData = getString(row.getCell(k++));
            String thuData = getString(row.getCell(k++));
            String friData = getString(row.getCell(k++));
            String satData = getString(row.getCell(k++));

            String[] dayData = {sunData, monData, tueData, wedData, thuData, friData, satData};

            List<Schedule> scheduleList = getSchedule(dayData);

            String landline1Str = "";
            String landline2Str = "";

            if (mobile1 == 0)
                mobile1 = null;
            if (mobile2 == 0)
                mobile2 = null;
            if (landline1 != 0)
                landline1Str = "" + landline1;
            if (landline2 != 0)
                landline2Str = "" + landline2;
            if (secMobile == 0)
                secMobile = null;
            Map<String, Long> sgMap = apiHelper.getSgNameMap();

            Long sgId = sgMap.get(name.toLowerCase().trim());

            Long parentCenterId = sgMap.get(parentCenter.toLowerCase());

            City city = StaticContent.getCityObjectFromName(cityName);

            System.out.println(name + ": " + city);

            if (Strings.isNullOrEmpty(secName)) {
                secName = "No secretary";
            }

            if (null == secMobile || 0 == secMobile) {
                secMobile = 1234567890l;
            }

            if (null == mobile1 || 0 == mobile1) {
                mobile1 = 1234567890l;
            }

            if (Strings.isNullOrEmpty(addr1)) {
                addr1 = "No Address";
            }

            if (0 == pinCode) {
                pinCode = 12345l;
            }

            SatsangGhar satsangGhar = SatsangGhar.builder()
                    .id(sgId)
                    .name(name)
                    .centerType(type)
                    .parentCenterid(parentCenterId)
                    .address1(addr1)
                    .address2(addr2)
                    .city(city.getCode())
                    .state(city.getStateCode())
                    .pinCode(pinCode + "")
                    .mobile1(mobile1)
                    .mobile2(mobile2)
                    .landline1(landline1Str)
                    .landline2(landline2Str)
                    .secName(secName)
                    .secMobile(secMobile)
                    .build();

            apiHelper.addSatsangGhar(satsangGhar, scheduleList);
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

    private static double getLong(Cell cell) {

        if (cell == null)
            return 0;
        System.out.println(cell);
        cell.getNumericCellValue();

        return cell.getNumericCellValue();
    }

    private static List<Schedule> getSchedule(String[] dataArray) {

        String[] dayArray = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};

        List<Schedule> list = new ArrayList<>();
        for (int i = 0; i < dayArray.length; i++) {
            String data = dataArray[i];
            String day = dayArray[i];
            if (Strings.isNullOrEmpty(data))
                continue;
            System.out.println(data);
            String lang = data.split("#")[0];
            String time = data.split("#")[1];
            String languages[] = lang.split(",");
            for (int j = 0; j < languages.length; j++) {
                if ("CD".equalsIgnoreCase(languages[j]))
                    languages[j] = "CD";
                else
                    languages[j] = WordUtils.capitalize(languages[j].toLowerCase());
            }

            Schedule schedule = Schedule.builder().build();
            schedule.setDay(day);
            schedule.setTime(time);
            schedule.setLang(languages);
            System.out.println("-----------ARUn-----------");

            list.add(schedule);
        }

        return list;
    }
}

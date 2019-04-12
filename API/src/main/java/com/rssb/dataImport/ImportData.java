package com.rssb.dataImport;

import com.rssb.api.helper.StaticContent;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

public class ImportData {

    public static void main(String[] args) throws Exception {

////
////        if (args.length == 0) {
////            System.out.println("please provide file to import");
////            return;
////        }
////        String path = args[0];
        String path = "/home/arun/Indore - sample-import-SG-Contributor-v2.xlsx";
        try {
            FileInputStream file = new FileInputStream(new File(path));
        } catch (Exception e) {

            System.out.println("------------INVALID FILE PATH: " + path + "--------------");
            e.printStackTrace();
            return;
        }

        System.out.println("-----------------------------------------------");
        System.out.println("Starting import");

        ImportCities.importCities(path);
        StaticContent.reloadData();
        ImportSG.importSG(path);
        ImportSG.importSG(path);
        List<String> issues = ImportContributor.importCon(path);

        System.err.println("Issue in Contributor import");
        for (int i = 0; i < issues.size(); i++) {
            if (!issues.contains("SG name"))
                System.err.println(issues.get(i));
        }

//         path = "/home/arun/Satsang CD.xlsx";
//        ImportCD.importCon(path);
    }
}

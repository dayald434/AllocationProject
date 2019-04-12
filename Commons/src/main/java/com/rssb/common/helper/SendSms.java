package com.rssb.common.helper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class SendSms {
    public synchronized static String sendSms(String messageText) throws Exception {
        // Construct data
        String apiKey = "apikey=" + "4GZ6vKkT5J0-Kg8J8wSxjKAHjhqPc6pLAaJIDnOKWP";
        String message = "&message=" + messageText;
        String sender = "&sender=" + "TXTLCL";
        String numbers = "&numbers=" + "9972595040";

        // Send data
        HttpURLConnection conn = (HttpURLConnection) new URL("https://api.textlocal.in/send/?").openConnection();
        String data = apiKey + numbers + message + sender;
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
        conn.getOutputStream().write(data.getBytes("UTF-8"));
        final BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        final StringBuffer stringBuffer = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            stringBuffer.append(line);
        }
        rd.close();

        return stringBuffer.toString();
    }

    public static void main(String[] args) throws  Exception {

       String s =sendSms("Test  Allocation Message From Arun!!! ");
        System.out.println(s);
    }
}



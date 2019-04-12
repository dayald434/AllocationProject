package com.rssb.common.helper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@Slf4j
public class HttpHelper {

    @Data
    @AllArgsConstructor
    public static class HttpResponse {
        String resp;
        int respCode;
    }

    public static HttpResponse get(String url) throws Exception {
        return makeHttpCall(url, "GET");
    }

    public static HttpResponse post(String url) throws Exception {
        return makeHttpCall(url, "POST");
    }

    private static HttpResponse makeHttpCall(String url, String method) throws Exception {
        log.debug("Http Call: {}", url);
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setRequestMethod(method);
        int respCode = con.getResponseCode();
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        return new HttpResponse(response.toString(), respCode);
    }
}

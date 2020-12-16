/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import jlp0011.dto.UserDTO;

/**
 *
 * @author DELL
 */
public class APIWapper {
    private final String appId = "3350648078375882";
    private final String appSecret = "7888781bc9394ee2a41d23d35cd4e773";
    private final String redirectUrl = "http://localhost:8084/NguyenHoangMinhTu_Lab2/loginFacebook";
    private String accessToken;

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessToken(String code) throws IOException {
        String accessTokenLink = "https://graph.facebook.com/oauth/access_token?"
                + "client_id=%s"
                + "&client_secret=%s"
                + "&redirect_uri=%s"
                + "&code=%s";
        accessTokenLink = String.format(accessTokenLink, appId, appSecret, redirectUrl, code);
        String result = NetUtils.getResult(accessTokenLink);
        JsonObject jobj = new Gson().fromJson(result, JsonObject.class);
        String token = jobj.get("access_token").toString().replaceAll("\"", "");
        return token;
    }

    public UserDTO getAccountInfo() throws IOException {
        String infoUrl = "https://graph.facebook.com/me?access_token=%s";
        infoUrl = String.format(infoUrl, this.accessToken);
        String result = NetUtils.getResult(infoUrl);
        UserDTO userDto = new Gson().fromJson(result,UserDTO.class);
        if (userDto == null) {
            return null;
        }
        return userDto;
    }
}

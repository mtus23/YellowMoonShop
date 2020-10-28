/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0011.util;

import java.awt.Image;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;

/**
 *
 * @author DELL
 */
public class ValidImage {
    public static boolean isImageExist(String imageLink) {
        try {
            Image image = ImageIO.read(new URL(imageLink));
            if (image != null) {
                return true;
            }
        } catch (IOException ex) {
            return false;
        }
        return false;
    }
}

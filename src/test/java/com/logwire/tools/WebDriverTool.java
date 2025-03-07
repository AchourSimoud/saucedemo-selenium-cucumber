package com.logwire.tools;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class WebDriverTool {

    static public WebDriver driver;

    static public void setUpDriver(){
        String browser = System.getProperty("browser","chrome");
        switch (browser.toLowerCase()) {
            case "chrome":
                driver = new ChromeDriver();
                break;

            case "firefoxe":
                driver = new FirefoxDriver();
                break;
                
            default:
                driver = new ChromeDriver();
                break;
        }
        driver.manage().window().maximize();
        
    }

    static public WebDriver getDriver(){
        return driver;
    }

    static public void tearDown(){
        if (driver != null){
            driver.quit();
            driver = null;
        }
    }
}

package com.logwire.tools;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeOptions; // Import ChromeOptions

public class WebDriverTool {

    static public WebDriver driver;

    static public void setUpDriver(){
        String browser = System.getProperty("browser","chrome");
        switch (browser.toLowerCase()) {
            case "chrome":
                ChromeOptions chromeOptions = new ChromeOptions();
                chromeOptions.addArguments("--headless=new");
                chromeOptions.addArguments("--no-sandbox");
                chromeOptions.addArguments("--disable-dev-shm-usage");
                chromeOptions.addArguments("--disable-gpu");
                chromeOptions.addArguments("--disable-software-rasterizer");
                chromeOptions.addArguments("--remote-debugging-port=9222");
                chromeOptions.addArguments("--disable-crash-reporter");   // Ajout pour éviter des crashs silencieux
                chromeOptions.addArguments("--disable-features=VizDisplayCompositor"); // Pour stabilité en headless
                driver = new ChromeDriver(chromeOptions);
                break;


            case "firefoxe":
                driver = new FirefoxDriver();
                break;
                
            default:
                driver = new ChromeDriver();
                break;

        }
        //driver.manage().window().maximize();
        
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

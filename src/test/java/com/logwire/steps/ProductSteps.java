package com.logwire.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.openqa.selenium.WebDriver;

import com.logwire.pages.InventoryPage;
import com.logwire.pages.LoginPage;
import com.logwire.tools.WebDriverTool;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class ProductSteps {
    WebDriver driver;
    LoginPage loginPage;
    InventoryPage inventoryPage;

    public ProductSteps(){
        this.driver = WebDriverTool.getDriver();
        this.loginPage = new LoginPage(this.driver);
        this.inventoryPage = new InventoryPage(this.driver);
    }

    @Then("la liste des produits est remplie")
    public void la_liste_des_produits_est_remplie() {
        assertTrue(this.inventoryPage.getNbrProduits()>0);
    }

    @Given("je suis sur la page produits")
    public void je_suis_sur_la_page_produits() {
        this.driver.get("https://www.saucedemo.com/");
        this.loginPage.login("standard_user", "secret_sauce");
    }

    @When("je click sur les boutons add to cart")
    public void je_click_sur_les_boutons_add_to_cart() {
        this.inventoryPage.addProduct();
    }

    @Then("les boutons remove apparaissent")
    public void les_boutons_remove_apparaissent() {
        assertEquals(6, this.inventoryPage.getRemoveBoutons().size());
    }

    @When("je click sur les bouton remove")
    public void je_click_sur_les_bouton_remove() {
        this.inventoryPage.removeProduct();
    }

    @Then("les boutons remove disparaissent")
    public void les_boutons_remove_disparaissent() {
        assertEquals(0, this.inventoryPage.getRemoveBoutons().size());
    }

    @When("je click sur le bouton logout")
    public void je_click_sur_le_bouton_logout() {
        this.inventoryPage.logout();
    }

    @When("je click sur le menu gauche")
    public void je_click_sur_le_menu_gauche() {
        this.inventoryPage.clickmenu();
    }

    @Then("je suis rederige sur la page accueil")
    public void je_suis_rederige_sur_la_page_accueil() {
        assertEquals("https://www.saucedemo.com/",this.driver.getCurrentUrl());
    }

    @Then("la liste est ordonnee par {string}")
    public void la_liste_est_ordonnee_par(String filtre) {
        if (filtre == "Name (A to Z)") {
            List<String> nomList = this.inventoryPage.getNomList();
            List<String> nomListTriee = new ArrayList<>(nomList);
            Collections.sort(nomListTriee);
            assertTrue(nomListTriee.equals(nomList));
        }else if(filtre == "Name (Z to A)"){
            List<String> nomList = this.inventoryPage.getNomList();
            List<String> nomListTriee = new ArrayList<>(nomList);
            Collections.sort(nomListTriee, Collections.reverseOrder());
            assertTrue(nomListTriee.equals(nomList));
        }else if(filtre == "Price (low to high)"){
            List<Float> prixListOriginale = this.inventoryPage.getPrixList();
            List<Float> prixListTriee = new ArrayList<>(prixListOriginale);
            Collections.sort(prixListTriee);
            assertTrue(prixListOriginale.equals(prixListTriee));
        }else if(filtre == "Price (high to low)"){
            List<Float> prixListOriginale = this.inventoryPage.getPrixList();
            List<Float> prixListTriee = new ArrayList<>(prixListOriginale);
            Collections.sort(prixListTriee, Collections.reverseOrder());
            assertTrue(prixListOriginale.equals(prixListTriee));
        }else{
            assertTrue(true);
        }
    }

    @When("je trie les produits par {string}")
    public void je_trie_les_produits_par(String s) {
        this.inventoryPage.ordreProduits(s);
    }

    @When("je click sur le bouton reset app")
    public void je_click_sur_le_bouton_reset_app() {
        this.inventoryPage.reset();
    }

    @Then("le badge du panier disparait")
    public void le_badge_du_panier_disparait() {
        assertEquals(0, this.inventoryPage.getBadgeNumber());
    }

    @When("je click sur le panier")
    public void je_click_sur_le_panier() {
        this.inventoryPage.clickPanier();
    }


}

package com.huhurezmarius.restaurants.controller;

import com.huhurezmarius.restaurants.model.Meal;
import com.huhurezmarius.restaurants.model.Restaurant;
import org.junit.jupiter.api.Test;

import java.util.HashSet;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;

class RestaurantControllerTest {

    @Test
    void defaultRestaurantBuilderCreatesExpectedObject() {
        Restaurant restaurant = defaultRestaurant();

        assertEquals("Test", restaurant.getName());
        assertEquals("Test restaurant", restaurant.getDescription());
        assertEquals(1, restaurant.getMeals().size());
    }

    private Restaurant defaultRestaurant() {
        Restaurant restaurant = new Restaurant();
        restaurant.setId(1L);
        restaurant.setName("Test");
        restaurant.setDescription("Test restaurant");
        Set<Meal> meals = new HashSet<>();
        Meal meal = new Meal();
        meal.setPrice(2.0);
        meal.setDescription("orange veg");
        meal.setName("carrot");
        meals.add(meal);
        restaurant.setMeals(meals);
        return restaurant;
    }
}

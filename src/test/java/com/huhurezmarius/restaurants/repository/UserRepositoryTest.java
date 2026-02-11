package com.huhurezmarius.restaurants.repository;

import com.huhurezmarius.restaurants.model.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

@DataJpaTest
class UserRepositoryTest {

    @Autowired
    UserRepository userRepository;

    @Test
    void addUserTest() {
        User user = new User();
        user.setUsername("testUser");
        user.setEmail("testUser@gmail.com");
        user.setPassword("password");

        User expectedSavedUser = userRepository.saveAndFlush(user);
        Assertions.assertEquals("testUser@gmail.com", expectedSavedUser.getEmail());
        Assertions.assertEquals("testUser", expectedSavedUser.getUsername());
        Assertions.assertEquals("password", expectedSavedUser.getPassword());
    }
}

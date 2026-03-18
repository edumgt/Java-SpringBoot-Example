package com.huhurezmarius.restaurants.init;

import com.huhurezmarius.restaurants.enums.RoleEnum;
import com.huhurezmarius.restaurants.enums.StatusEnum;
import com.huhurezmarius.restaurants.enums.TypeEnum;
import com.huhurezmarius.restaurants.model.Role;
import com.huhurezmarius.restaurants.model.Status;
import com.huhurezmarius.restaurants.model.Type;
import com.huhurezmarius.restaurants.model.User;
import com.huhurezmarius.restaurants.repository.RoleRepository;
import com.huhurezmarius.restaurants.repository.StatusRepository;
import com.huhurezmarius.restaurants.repository.TypeRepository;
import com.huhurezmarius.restaurants.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

/**
 * DataInitializer runs at application startup to ensure required reference data
 * and test accounts exist in the database regardless of which DB profile is active.
 *
 * Test accounts created:
 *   - test1@test.com / 123456  (ROLE_USER)
 *   - test2@test.com / 123456  (ROLE_USER)
 */
@Component
public class DataInitializer implements ApplicationRunner {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private TypeRepository typeRepository;

    @Autowired
    private StatusRepository statusRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        initRoles();
        initTypes();
        initStatuses();
        initTestUsers();
    }

    private void initRoles() {
        for (RoleEnum roleEnum : RoleEnum.values()) {
            if (roleRepository.findByName(roleEnum) == null) {
                roleRepository.save(new Role(roleEnum));
            }
        }
    }

    private void initTypes() {
        for (TypeEnum typeEnum : TypeEnum.values()) {
            if (typeRepository.findByName(typeEnum) == null) {
                typeRepository.save(new Type(typeEnum));
            }
        }
    }

    private void initStatuses() {
        for (StatusEnum statusEnum : StatusEnum.values()) {
            if (statusRepository.findByName(statusEnum) == null) {
                statusRepository.save(new Status(statusEnum));
            }
        }
    }

    private void initTestUsers() {
        createTestUserIfAbsent("test1", "test1@test.com", "123456");
        createTestUserIfAbsent("test2", "test2@test.com", "123456");
    }

    private void createTestUserIfAbsent(String username, String email, String rawPassword) {
        if (!userRepository.existsByEmail(email)) {
            User user = new User(username, email, passwordEncoder.encode(rawPassword));
            user.setEnabled(true);
            user.setBlocked(false);

            Set<Role> roles = new HashSet<>();
            roles.add(roleRepository.findByName(RoleEnum.ROLE_USER));
            user.setRoles(roles);

            Set<Type> types = new HashSet<>();
            types.add(typeRepository.findByName(TypeEnum.EMAIL));
            user.setTypes(types);

            userRepository.save(user);
        }
    }
}

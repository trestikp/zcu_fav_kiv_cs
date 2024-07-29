package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
import cz.zcu.kiv.pia.bikesharing.business.domain.Location;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeAlreadyOnRideException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotFoundException;
import cz.zcu.kiv.pia.bikesharing.business.exception.BikeNotServiceableException;
import cz.zcu.kiv.pia.bikesharing.data.repository.IBikeRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jms.core.JmsTemplate;

import java.time.LocalDateTime;
import java.time.Period;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BikeServiceTest {
    @Mock
    private IBikeRepository bikeRepository;

    @Mock
    private JmsTemplate jmsTemplate;

    private BikeService bikeService;

    private static final Period SERVICE_INTERVAL = Period.ofMonths(2);

    @BeforeEach
    void setUp() {
        this.bikeService = new BikeService(bikeRepository, jmsTemplate, SERVICE_INTERVAL);
    }

    @Test
    void whenGetBikesDueForService_returnListOfBikes() {
        // prepare - repository filters the bikes at DB level (returns only due for service - checking if interval is valid should be done in repository test)
        when(bikeRepository.getBikesDueForService()).thenReturn(List.of(
                mock(Bike.class), mock(Bike.class)
        ));

        // test
        Collection<Bike> result = bikeService.getBikesDueForService();

        // test
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    void givenBikeNotDueForService_whenMarkServiced_ThrowsBikeNotServiceableException() {
        // prepare
        UUID bikeId = UUID.randomUUID();
        Bike existingBike = new Bike(bikeId, null, LocalDateTime.now()); // .now() is not for service (within last 2 months)
        when(bikeRepository.getById(bikeId)).thenReturn(existingBike);

        // test
        assertThrows(BikeNotServiceableException.class, () -> bikeService.markServiced(bikeId));
    }

    @Test
    void givenBikeDueForService_whenMarkServiced_MarksBikeAsServiced() {
        // prepare
        UUID bikeId = UUID.randomUUID();
        Bike existingBike = new Bike(bikeId, null, LocalDateTime.MIN); // MIN is older than 2 months
        when(bikeRepository.getById(bikeId)).thenReturn(existingBike);

        // test
        LocalDateTime servicedAfter = LocalDateTime.now().minus(SERVICE_INTERVAL); // bike should now be marked as serviced .now()

        assertDoesNotThrow(() -> bikeService.markServiced(bikeId));
        assertTrue(existingBike.getLastServiceTimestamp().isAfter(servicedAfter)); // service date is withing service interval
        verify(bikeRepository, times(1)).save(existingBike);
    }

    @Test
    void givenBike_whenStartRide_bikeUpdated() {
        // prepare
        UUID bikeId = UUID.randomUUID();
        Location initialLocation = new Location(5.5, 1.1);
        Bike existingBike = new Bike(bikeId);
        when(bikeRepository.getById(bikeId)).thenReturn(existingBike);

        // test
        assertDoesNotThrow(() -> bikeService.startBikeRide(bikeId, initialLocation));
        assertNull(existingBike.getStand()); // this means bike is on ride
        assertEquals(initialLocation, existingBike.getLocation());
        verify(bikeRepository, times(1)).save(existingBike);
    }

    @Test
    void givenBike_whenMoveBike_bikeUpdatedLocation() throws BikeNotFoundException, BikeAlreadyOnRideException {
        // prepare
        UUID bikeId = UUID.randomUUID();
        Location initialLocation = new Location(5.5, 1.1);
        Location newLocation = new Location(8.8, 8.8);
        Bike existingBike = new Bike(bikeId, initialLocation, LocalDateTime.now());
        when(bikeRepository.getById(bikeId)).thenReturn(existingBike);
        when(bikeRepository.isBikeOnRide(existingBike)).thenReturn(true);

        // start test (bike is at initial location before starting ride)
        existingBike.startBikeRide(initialLocation);
        assertEquals(initialLocation, existingBike.getLocation());

        // test move
        assertDoesNotThrow(() -> bikeService.moveBike(bikeId, newLocation));
        assertEquals(newLocation, existingBike.getLocation());
        verify(bikeRepository, times(1)).save(existingBike);
        verify(jmsTemplate, times(1)).convertAndSend(anyString(), anyString());
    }

    @Test
    void givenNoBike_whenMoveBike_throwBikeNotFoundException() {
        // Arrange
        UUID bikeId = UUID.randomUUID();
        Location location = new Location(1.0, 1.0);
        when(bikeRepository.getById(bikeId)).thenReturn(null); // bike with this id doesnt exist

        // Act and Assert
        assertThrows(BikeNotFoundException.class, () -> bikeService.moveBike(bikeId, location));
        verify(bikeRepository, never()).save(any());
        verify(jmsTemplate, never()).convertAndSend(anyString(), anyString());
    }

    @Test
    void givenBikeNotOnRide_whenMoveBike_throwsBikeAlreadyOnRideException() {
        // prepare
        UUID bikeId = UUID.randomUUID();
        Location location = new Location(1.0, 1.0);
        Bike existingBike = new Bike(bikeId);
        when(bikeRepository.getById(bikeId)).thenReturn(existingBike);

        /**
         * FIXME: this is an error in code. This checks if bike is on ride, so it can move.
         */

        // Act and Assert
        assertThrows(BikeAlreadyOnRideException.class, () -> bikeService.moveBike(bikeId, location));
        verify(bikeRepository, never()).save(any());
        verify(jmsTemplate, never()).convertAndSend(anyString(), anyString());
    }

    @Test
    void whenRemoveBikeFromClient_messageIsSent() {
        UUID bikeId = UUID.randomUUID();
        assertDoesNotThrow(() -> bikeService.removeBikeFromClient(bikeId));
        verify(jmsTemplate, times(1)).convertAndSend(anyString(), anyString());
    }

}
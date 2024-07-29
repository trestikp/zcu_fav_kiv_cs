//package cz.zcu.kiv.pia.bikesharing.business.service;
//
//import cz.zcu.kiv.pia.bikesharing.business.domain.Bike;
//import cz.zcu.kiv.pia.bikesharing.business.domain.Ride;
//import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;
//import cz.zcu.kiv.pia.bikesharing.business.domain.User;
//import cz.zcu.kiv.pia.bikesharing.data.repository.IBikeRepository;
//import cz.zcu.kiv.pia.bikesharing.data.repository.IRideRepository;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.mockito.Mock;
//import org.mockito.junit.jupiter.MockitoExtension;
//
//import java.util.UUID;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.Mockito.*;
//
//@ExtendWith(MockitoExtension.class)
//class RideServiceTest {
//    @Mock
//    private IRideRepository rideRepository;
//
//    @Mock
//    private IBikeService bikeService;
//
//    @Mock
//    private IBikeRepository bikeRepository;
//
//    private RideService rideService;
//
//    @BeforeEach
//    void setUp() {
//        this.rideService = new RideService(rideRepository, bikeService, bikeRepository);
//    }
//
//    @Test
//    void testStartRide_ValidParameters_ReturnsRide() {
//        // prepare
//        User user = new User(UUID.randomUUID());
//        Bike bike = new Bike(UUID.randomUUID());
//        Stand startStand = new Stand(UUID.randomUUID());
//        when(rideRepository.hasUserRideInProgress(user)).thenReturn(false);
//        when(bike.getStand()).thenReturn(startStand);
//        when(bikeRepository.save(any())).thenReturn(bike);
//        when(rideRepository.save(any())).thenReturn(new Ride(user, bike, startStand));
//
//        // Act
//        Ride result = rideService.startRide(user, bike, startStand);
//
//        // Assert
//        assertNotNull(result);
//        verify(bikeService, times(1)).startBikeRide(eq(bike.getId()), any());
//    }
//
//    @Test
//    void testStartRide_UserAlreadyRiding_ThrowsUserAlreadyRidingException() {
//        // Arrange
//        User user = new User("username", "password", "ROLE_USER");
//        Bike bike = new Bike();
//        Stand startStand = new Stand();
//        when(rideRepository.hasUserRideInProgress(user)).thenReturn(true);
//
//        // Act and Assert
//        assertThrows(UserAlreadyRidingException.class, () -> rideService.startRide(user, bike, startStand));
//        verify(bikeService, never()).startBikeRide(any(), any());
//    }
//
//    @Test
//    void testStartRide_BikeNotAtStand_ThrowsBikeAlreadyOnRideException() {
//        // Arrange
//        User user = new User("username", "password", "ROLE_USER");
//        Bike bike = new Bike();
//        Stand startStand = new Stand();
//        when(rideRepository.hasUserRideInProgress(user)).thenReturn(false);
//        when(bike.getStand()).thenReturn(null);
//
//        // Act and Assert
//        assertThrows(BikeAlreadyOnRideException.class, () -> rideService.startRide(user, bike, startStand));
//        verify(bikeService, never()).startBikeRide(any(), any());
//    }
//
//    // Add more test cases for various scenarios of startRide method
//
//    @Test
//    void testCompleteRide_ValidParameters_CompletesRide() {
//        // Arrange
//        User user = new User("username", "password", "ROLE_USER");
//        Bike bike = new Bike();
//        Stand startStand = new Stand();
//        Ride ride = new Ride(user, bike, startStand);
//        Stand endStand = new Stand();
//        when(rideRepository.getById(ride.getId())).thenReturn(ride);
//        when(bikeRepository.save(any())).thenReturn(bike);
//        when(rideRepository.save(any())).thenReturn(ride);
//
//        // Act
//        assertDoesNotThrow(() -> rideService.completeRide(ride, bike, endStand));
//
//        // Assert
//        assertTrue(ride.isCompleted());
//        verify(bikeRepository, times(1)).save(bike);
//    }
//
//    @Test
//    void testCompleteRide_RideNotFound_ThrowsRideNotFoundException() {
//        // Arrange
//        Ride ride = new Ride(); // Create a ride with default values
//        Bike bike = new Bike();
//        Stand endStand = new Stand();
//        when(rideRepository.getById(ride.getId())).thenReturn(null);
//
//        // Act and Assert
//        assertThrows(RideNotFoundException.class, () -> rideService.completeRide(ride, bike, endStand));
//        verify(bikeRepository, never()).save(any());
//    }
//
//    // Add more test cases for various scenarios of completeRide method
//
//    @Test
//    void testGetRides_ValidUser_ReturnsRides() {
//        // Arrange
//        User user = new User("username", "password", "ROLE_USER");
//        when(rideRepository.getByUser(user)).thenReturn(new ArrayList<>());
//
//        // Act
//        Collection<Ride> result = rideService.getRides(user);
//
//        // Assert
//        assertNotNull(result);
//        assertTrue(result.isEmpty());
//    }
//
//    // Add more test cases for various scenarios of getRides method
//
//    @Test
//    void testCalculateDistance_ValidCoordinates_ReturnsDistance() {
//        // Arrange
//        double lat1 = 0.0;
//        double lon1 = 0.0;
//        double lat2 = 1.0;
//        double lon2 = 1.0;
//
//        // Act
//        double result = rideService.calculateDistance(lat1, lon1, lat2, lon2);
//
//        // Assert
//        assertTrue(result >= 0);
//    }
//
//    @Test
//    void testCalculateDistance_FailedCoordinates_ReturnsNegative1() {
//        // Arrange
//        double lat1 = 0.0;
//        double lon1 = 0.0;
//        double lat2 = 91.0; // Invalid latitude
//
//        // Act
//        double result = rideService.calculateDistance(lat1, lon1, lat2, lon2);
//
//        // Assert
//        assertEquals(-1, result);
//    }
//
//    // Add more test cases for various scenarios of calculateDistance method
//
//    @Test
//    void testCompleteAllRides_CompletesAllRides() {
//        // Act
//        assertDoesNotThrow(() -> rideService.completeAllRides());
//
//        // Assert
//        verify(rideRepository, times(1)).completeAllRides();
//    }
//
//}
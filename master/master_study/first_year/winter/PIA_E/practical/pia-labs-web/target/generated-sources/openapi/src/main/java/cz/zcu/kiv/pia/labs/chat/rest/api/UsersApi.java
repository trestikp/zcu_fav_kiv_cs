/**
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech) (6.2.0).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */
package cz.zcu.kiv.pia.labs.chat.rest.api;

import cz.zcu.kiv.pia.labs.chat.rest.model.ProblemVO;
import java.util.UUID;
import cz.zcu.kiv.pia.labs.chat.rest.model.UserVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import javax.annotation.Generated;

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-10-15T20:52:12.512088549+02:00[Europe/Prague]")
@Tag(name = "Users", description = "Users management")
@RequestMapping("${openapi.kIVPIALabsREST.base-path:}")
public interface UsersApi {

    /**
     * POST /v1/users
     * Creates a new user.
     *
     * @param userVO  (optional)
     * @return When user is successfully created. (status code 201)
     *         or When request is invalid. (status code 400)
     *         or When user with given name already exists. (status code 409)
     */
    @Operation(
        operationId = "createUser",
        tags = { "Users" },
        responses = {
            @ApiResponse(responseCode = "201", description = "When user is successfully created.", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = UserVO.class)),
                @Content(mediaType = "application/problem+json", schema = @Schema(implementation = UserVO.class))
            }),
            @ApiResponse(responseCode = "400", description = "When request is invalid.", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = ProblemVO.class)),
                @Content(mediaType = "application/problem+json", schema = @Schema(implementation = ProblemVO.class))
            }),
            @ApiResponse(responseCode = "409", description = "When user with given name already exists.", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = ProblemVO.class)),
                @Content(mediaType = "application/problem+json", schema = @Schema(implementation = ProblemVO.class))
            })
        }
    )
    @RequestMapping(
        method = RequestMethod.POST,
        value = "/v1/users",
        produces = "application/json",
        consumes = "application/json"
    )
    ResponseEntity<UserVO> createUser(
        @Parameter(name = "UserVO", description = "") @RequestBody(required = false) UserVO userVO
    );


    /**
     * GET /v1/rooms/{roomId}/users
     * Returns chat room users.
     *
     * @param roomId Unique chat room ID. (required)
     * @return When chat room users are successfully retrieved. (status code 200)
     *         or When chat room with given ID cannot be found. (status code 404)
     */
    @Operation(
        operationId = "getRoomUsers",
        tags = { "Users" },
        responses = {
            @ApiResponse(responseCode = "200", description = "When chat room users are successfully retrieved.", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = UserVO.class)),
                @Content(mediaType = "application/problem+json", schema = @Schema(implementation = UserVO.class))
            }),
            @ApiResponse(responseCode = "404", description = "When chat room with given ID cannot be found.", content = {
                @Content(mediaType = "application/json", schema = @Schema(implementation = ProblemVO.class)),
                @Content(mediaType = "application/problem+json", schema = @Schema(implementation = ProblemVO.class))
            })
        }
    )
    @RequestMapping(
        method = RequestMethod.GET,
        value = "/v1/rooms/{roomId}/users",
        produces = "application/json"
    )
    ResponseEntity<List<UserVO>> getRoomUsers(
        @Parameter(name = "roomId", description = "Unique chat room ID.", required = true) @PathVariable("roomId") UUID roomId
    );

}
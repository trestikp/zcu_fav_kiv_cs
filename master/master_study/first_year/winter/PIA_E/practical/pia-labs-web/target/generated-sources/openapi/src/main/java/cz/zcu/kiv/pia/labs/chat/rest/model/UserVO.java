package cz.zcu.kiv.pia.labs.chat.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import java.util.UUID;
import java.io.Serializable;
import java.time.OffsetDateTime;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import javax.annotation.Generated;

/**
 * UserVO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-10-15T20:52:12.512088549+02:00[Europe/Prague]")
public class UserVO implements Serializable {

  private static final long serialVersionUID = 1L;

  @JsonProperty("id")
  private UUID id;

  @JsonProperty("username")
  private String username;

  public UserVO id(UUID id) {
    this.id = id;
    return this;
  }

  /**
   * Get id
   * @return id
  */
  @Schema(name = "id", accessMode = Schema.AccessMode.READ_ONLY, required = false)
  public UUID getId() {
    return id;
  }

  public void setId(UUID id) {
    this.id = id;
  }

  public UserVO username(String username) {
    this.username = username;
    return this;
  }

  /**
   * User's unique username
   * @return username
  */
  @Schema(name = "username", example = "john.doe", description = "User's unique username", required = true)
  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    UserVO userVO = (UserVO) o;
    return Objects.equals(this.id, userVO.id) &&
        Objects.equals(this.username, userVO.username);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, username);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class UserVO {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    username: ").append(toIndentedString(username)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}


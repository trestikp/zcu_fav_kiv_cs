package cz.zcu.kiv.pia.labs.chat.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import cz.zcu.kiv.pia.labs.chat.rest.model.UserVO;
import java.util.UUID;
import java.io.Serializable;
import java.time.OffsetDateTime;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import javax.annotation.Generated;

/**
 * RoomVO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-10-15T20:52:12.512088549+02:00[Europe/Prague]")
public class RoomVO implements Serializable {

  private static final long serialVersionUID = 1L;

  @JsonProperty("id")
  private UUID id;

  @JsonProperty("name")
  private String name;

  @JsonProperty("administrator")
  private UserVO administrator;

  public RoomVO id(UUID id) {
    this.id = id;
    return this;
  }

  /**
   * Get id
   * @return id
  */
  @Schema(name = "id", required = false)
  public UUID getId() {
    return id;
  }

  public void setId(UUID id) {
    this.id = id;
  }

  public RoomVO name(String name) {
    this.name = name;
    return this;
  }

  /**
   * Chat room name
   * @return name
  */
  @Schema(name = "name", example = "running", description = "Chat room name", required = true)
  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public RoomVO administrator(UserVO administrator) {
    this.administrator = administrator;
    return this;
  }

  /**
   * Get administrator
   * @return administrator
  */
  @Schema(name = "administrator", required = false)
  public UserVO getAdministrator() {
    return administrator;
  }

  public void setAdministrator(UserVO administrator) {
    this.administrator = administrator;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    RoomVO roomVO = (RoomVO) o;
    return Objects.equals(this.id, roomVO.id) &&
        Objects.equals(this.name, roomVO.name) &&
        Objects.equals(this.administrator, roomVO.administrator);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, name, administrator);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class RoomVO {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    name: ").append(toIndentedString(name)).append("\n");
    sb.append("    administrator: ").append(toIndentedString(administrator)).append("\n");
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


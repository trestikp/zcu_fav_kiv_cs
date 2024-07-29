package cz.zcu.kiv.pia.labs.chat.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import cz.zcu.kiv.pia.labs.chat.rest.model.UserVO;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.springframework.format.annotation.DateTimeFormat;
import java.io.Serializable;
import java.time.OffsetDateTime;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import javax.annotation.Generated;

/**
 * MessageVO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-10-15T20:52:12.512088549+02:00[Europe/Prague]")
public class MessageVO implements Serializable {

  private static final long serialVersionUID = 1L;

  @JsonProperty("id")
  private UUID id;

  @JsonProperty("author")
  private UserVO author;

  @JsonProperty("text")
  private String text;

  @JsonProperty("timestamp")
  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
  private OffsetDateTime timestamp;

  public MessageVO id(UUID id) {
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

  public MessageVO author(UserVO author) {
    this.author = author;
    return this;
  }

  /**
   * Get author
   * @return author
  */
  @Schema(name = "author", required = false)
  public UserVO getAuthor() {
    return author;
  }

  public void setAuthor(UserVO author) {
    this.author = author;
  }

  public MessageVO text(String text) {
    this.text = text;
    return this;
  }

  /**
   * Get text
   * @return text
  */
  @Schema(name = "text", example = "Morning run tomorrow, who's coming along?", required = true)
  public String getText() {
    return text;
  }

  public void setText(String text) {
    this.text = text;
  }

  public MessageVO timestamp(OffsetDateTime timestamp) {
    this.timestamp = timestamp;
    return this;
  }

  /**
   * Get timestamp
   * @return timestamp
  */
  @Schema(name = "timestamp", accessMode = Schema.AccessMode.READ_ONLY, required = false)
  public OffsetDateTime getTimestamp() {
    return timestamp;
  }

  public void setTimestamp(OffsetDateTime timestamp) {
    this.timestamp = timestamp;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    MessageVO messageVO = (MessageVO) o;
    return Objects.equals(this.id, messageVO.id) &&
        Objects.equals(this.author, messageVO.author) &&
        Objects.equals(this.text, messageVO.text) &&
        Objects.equals(this.timestamp, messageVO.timestamp);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, author, text, timestamp);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class MessageVO {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    author: ").append(toIndentedString(author)).append("\n");
    sb.append("    text: ").append(toIndentedString(text)).append("\n");
    sb.append("    timestamp: ").append(toIndentedString(timestamp)).append("\n");
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


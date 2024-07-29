package cz.zcu.kiv.pia.labs.chat.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import java.math.BigDecimal;
import java.io.Serializable;
import java.time.OffsetDateTime;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import javax.annotation.Generated;

/**
 * ProblemVO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-10-15T20:52:12.512088549+02:00[Europe/Prague]")
public class ProblemVO implements Serializable {

  private static final long serialVersionUID = 1L;

  @JsonProperty("type")
  private String type;

  @JsonProperty("title")
  private String title;

  @JsonProperty("status")
  private BigDecimal status;

  @JsonProperty("detail")
  private String detail;

  @JsonProperty("instance")
  private String instance;

  public ProblemVO type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Common problem type URL
   * @return type
  */
  @Schema(name = "type", description = "Common problem type URL", required = false)
  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public ProblemVO title(String title) {
    this.title = title;
    return this;
  }

  /**
   * HTTP status description
   * @return title
  */
  @Schema(name = "title", description = "HTTP status description", required = true)
  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public ProblemVO status(BigDecimal status) {
    this.status = status;
    return this;
  }

  /**
   * HTTP status code
   * @return status
  */
  @Schema(name = "status", description = "HTTP status code", required = true)
  public BigDecimal getStatus() {
    return status;
  }

  public void setStatus(BigDecimal status) {
    this.status = status;
  }

  public ProblemVO detail(String detail) {
    this.detail = detail;
    return this;
  }

  /**
   * Detailed problem description
   * @return detail
  */
  @Schema(name = "detail", description = "Detailed problem description", required = true)
  public String getDetail() {
    return detail;
  }

  public void setDetail(String detail) {
    this.detail = detail;
  }

  public ProblemVO instance(String instance) {
    this.instance = instance;
    return this;
  }

  /**
   * Path where the problem occurred
   * @return instance
  */
  @Schema(name = "instance", description = "Path where the problem occurred", required = false)
  public String getInstance() {
    return instance;
  }

  public void setInstance(String instance) {
    this.instance = instance;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    ProblemVO problemVO = (ProblemVO) o;
    return Objects.equals(this.type, problemVO.type) &&
        Objects.equals(this.title, problemVO.title) &&
        Objects.equals(this.status, problemVO.status) &&
        Objects.equals(this.detail, problemVO.detail) &&
        Objects.equals(this.instance, problemVO.instance);
  }

  @Override
  public int hashCode() {
    return Objects.hash(type, title, status, detail, instance);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class ProblemVO {\n");
    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    title: ").append(toIndentedString(title)).append("\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
    sb.append("    detail: ").append(toIndentedString(detail)).append("\n");
    sb.append("    instance: ").append(toIndentedString(instance)).append("\n");
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


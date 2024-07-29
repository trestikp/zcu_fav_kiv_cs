package cz.zcu.kiv.nlp.ir.trec.data;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import cz.zcu.kiv.nlp.ir.trec.util.DocumentNewJsonDeserializer;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Tigi on 8.1.2015.
 *
 * Ukázka implementace rozhraní {@link Document}
 *
 * Tuto třídu si můžete libovolně upravovat pokud vám nevyhovuje nebo můžete vytvořit vlastní třídu, která
 * implementuje rozhraní {@link Document}.
 *
 * Class uses custom JSON deserializer and it's instances are created during deserialization.
 */
@JsonDeserialize(using = DocumentNewJsonDeserializer.class)
public class DocumentNew implements Document, Serializable {
    String text;
    String id;
    String title;
    Date date;
    Integer tokenCount = 0;
    final static long serialVersionUID = -5097715898427114007L;

    @Override
    public String toString() {
        return "DocumentNew{" +
                ", id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", date=" + date +
                "text='" + text + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public int getTokenCount() {
        return tokenCount;
    }

    @Override
    public void setTokenCount(int tokenCount) {
        this.tokenCount = tokenCount;
    }
}

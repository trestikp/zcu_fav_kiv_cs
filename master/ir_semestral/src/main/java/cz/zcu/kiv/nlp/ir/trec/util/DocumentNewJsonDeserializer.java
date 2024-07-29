package cz.zcu.kiv.nlp.ir.trec.util;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
import cz.zcu.kiv.nlp.ir.trec.data.DocumentNew;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Custom Jackson deserializer for DocumentNew class
 */
public class DocumentNewJsonDeserializer extends StdDeserializer<DocumentNew> {
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
    public DocumentNewJsonDeserializer() {
        this(null);
    }

    public DocumentNewJsonDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public DocumentNew deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException
    {
        DocumentNew doc = new DocumentNew();

        JsonNode node = jp.getCodec().readTree(jp);
        doc.setTitle(node.get("title").asText());
        doc.setText(node.get("content").asText());
        try {
            doc.setDate(sdf.parse(node.get("timestampCrawled").asText()));
        } catch (ParseException e) {
            doc.setDate(new Date(0)); // instead of "null" use start date
        }

        return doc;
    }
}

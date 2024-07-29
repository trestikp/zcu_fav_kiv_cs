package cz.pte.soaptest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;

public class Record {
    private Map<String, String> properties;
    private List<String> messages;

    public Record() {
        properties = new HashMap<>();
        messages = new ArrayList<>();
    }

    /**
     * Sets property of the objects. Uses XML attribute name as key.
     * @param key
     * @param value
     */
    public void setProperty(String key, String value) {
        properties.put(key, value);
    }

    public void putMessage(String msg) {
        messages.add(msg);
    }

    /**
     * Constructs (hopefully unique) ID for the records. First uses timestamp, but timestamp is only accurate to the
     * seconds. Additionally, uses contentLength and timeToFirstByte which are added to the timestamp duration result.
     * @return ID as Long converted to String
     */
    public String getElasticID() {
        Long id = 0L;

        ZonedDateTime z = ZonedDateTime.of(2000, 1, 1, 0, 0, 0, 0, ZoneId.of("+02:00"));
        ZonedDateTime ldt;
        if (properties.containsKey(Constants.REC_PROP_TIMESTAMP)) {
            String ts = properties.get(Constants.REC_PROP_TIMESTAMP);
            // TODO: FIXME lazy qucikfix - parse() exptect format +01:00 instead of +0100
            ts = ts.substring(0, ts.length() - 2) + ":" + ts.substring(ts.length() - 2);
            ldt = ZonedDateTime.parse(ts);
        }
        else
            ldt = ZonedDateTime.now();
        Duration d = Duration.between(z, ldt);

        id += d.toMillis(); // due to second precision need another determining parameters

        try {
            if (properties.containsKey(Constants.REC_PROP_CONTENT_LEN))
                id += Long.parseLong(properties.get(Constants.REC_PROP_CONTENT_LEN));
            if (properties.containsKey(Constants.REC_PROP_TTF_BYTE))
                id += Long.parseLong(properties.get(Constants.REC_PROP_TTF_BYTE));
        } catch (NumberFormatException ex) {
            System.err.println("Failed to parse Long");
            ex.printStackTrace();
        }

        return "" + id;
    }

    /**
     * Timestamp from results has 'yyyy-MM-dd HH:mm:ss', but this needs to be converted to ISO-8601. This method
     * MUST be run if getElasticID() is used, otherwise it will NOT work.
     */
    public void fixTimestampFormat() {
        if (!properties.containsKey(Constants.REC_PROP_TIMESTAMP))
            return;

        SimpleDateFormat origFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat ISO8601Format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
        try {
            Date d = origFormat.parse(properties.get(Constants.REC_PROP_TIMESTAMP));
            properties.put(Constants.REC_PROP_TIMESTAMP, ISO8601Format.format(d));
        } catch (ParseException e) {
            System.err.println("Failed to fix timestamp format. Unrecognized format.");
            e.printStackTrace();
        }
    }

    public String toJSONObjectString() {
        StringBuilder sb = new StringBuilder();
        sb.append('{');

        // serialize main properties
        properties.forEach((k, v) -> {
            sb.append("\"" + k + "\"");
            sb.append(':');
            sb.append("\"" + v + "\"");
            sb.append(',');
        });

//        sb.deleteCharAt(sb.length() - 1); // remove last ','

        // serialize messages as array of strings
        sb.append("\"messages\"");
        sb.append(':');
        sb.append('[');
        messages.forEach(m -> {
            sb.append('"');
            sb.append(m); // TODO: may not be escaping " (quote) in the string, also new lines might be problem
            sb.append('"');
            sb.append(',');
        });
        if (messages.size() > 0)
            sb.deleteCharAt(sb.length() - 1); // remove last ','
        sb.append(']');

        sb.append('}');
        return sb.toString();
    }

    @Override
    public String toString() {
        return toJSONObjectString();
    }
}

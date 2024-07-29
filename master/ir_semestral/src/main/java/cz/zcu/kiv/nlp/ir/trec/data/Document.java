package cz.zcu.kiv.nlp.ir.trec.data;

import java.util.Date;

/**
 * Created by Tigi on 8.1.2015.
 *
 * Rozhraní reprezentuje dokument, který je možné indexovat a vyhledávat.
 *
 * Implementujte toto rozhranní.
 *
 * Pokud potřebujete můžete do rozhranní přidat metody, ale signaturu stávajících metod neměnte.
 *
 */
public interface Document {

    /**
     * Text dokumentu
     * @return text
     */
    String getText();

    /**
     * Unikátní id dokumentu
     * @return id dokumentu
     */
    String getId();

    /**
     * Titulek dokumentu
     * @return titulek dokumentu
     */
    String getTitle();

    /**
     * Datum přidání dokumentu (tj. např. indexace nebo stažení nebo publikování
     *
     * @return datum vztažené k dokumentu
     */
    Date getDate();

    /**
     * Returns the number of tokens that the document contains. If no preprocessing is applied, then this number is
     * equal to number of words.
     * @return number of tokens (after preprocessing)
     */
    int getTokenCount();

    /**
     * Sets the number of tokens that the document contains. This method must be in public interface because it cannot
     * be determined what token count will be and it mustn't be final.
     * @param tokenCount
     */
    void setTokenCount(int tokenCount);
}

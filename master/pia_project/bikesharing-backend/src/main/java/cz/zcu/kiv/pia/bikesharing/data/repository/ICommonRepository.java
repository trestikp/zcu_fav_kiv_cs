package cz.zcu.kiv.pia.bikesharing.data.repository;

import java.util.List;

/**
 * Common repository interface. Defines basic CRUD operations.
 *
 * @param <T> Entity type.
 * @param <ID> Entity identifier type.
 */
public interface ICommonRepository<T, ID> {
    /**
     * Retrieves all entities.
     *
     * @return All entities.
     */
    List<T> getAll();
    /**
     * Retrieves entity by its identifier.
     *
     * @param id Identifier of the entity.
     * @return Entity with the given identifier.
     */
    T getById(ID id);
    /**
     * Saves entity.
     *
     * @param entity Entity to save.
     * @return Saved entity.
     */
    T save(T entity);
    /**
     * Deletes entity by its identifier.
     *
     * @param id Identifier of the entity.
     */
    void deleteById(ID id);
}

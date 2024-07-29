package cz.zcu.kiv.pia.bikesharing.data.repository;

import cz.zcu.kiv.pia.bikesharing.business.domain.Stand;

import java.util.UUID;

/**
 * Repository storing all information related to bike stands.
 */
public interface IStandRepository extends ICommonRepository<Stand, UUID> {

}

package com.beyondbit.struts.dao;

import java.util.*;

import com.beyondbit.hibernate.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public interface IDao {
    public void saveLaw(TbQlgkLaw law);
    public TbQlgkLaw loadLaw(String id);
    public void saveStep(TbQlgkPowerstdstep step);
    public void saveStd(TbQlgkPowerstd std);
    public void saveStepfile(TbQlgkStepfile stepfile);
    public void savePsfile(TbQlgkPsfile file);
    public TbQlgkStepfile loadStepfile(String stepid);
    public TbQlgkPsfile loadPsfile(String id);
    public TbQlgkPowerstdstep loadStep(String id);
    public TbQlgkSubpowerstd loadSubpowerstd(String id);
    public TbQlgkPowerstd loadPowerstd(String id);
    public void delPsfile(String stepid);
    public void delSubstd(String substdid);
    public void delPsfileByStepId(final String stepId) ;
    public List listStepFiles(String stepId);
    public List listPsFiles(String psId);

    /**
     * saveSubstd
     *
     * @param substd TbQlgkSubpowerstd
     */
    public void saveSubstd(TbQlgkSubpowerstd substd);

}

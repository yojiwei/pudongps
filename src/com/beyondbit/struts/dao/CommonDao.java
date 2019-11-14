package com.beyondbit.struts.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import com.beyondbit.hibernate.TbQlgkPsfile;
import com.beyondbit.hibernate.TbQlgkPowerstdstep;
import com.beyondbit.hibernate.TbQlgkStepfile;
import org.springframework.dao.*;
import com.beyondbit.hibernate.TbQlgkSubpowerstd;
import com.beyondbit.hibernate.TbQlgkLaw;
import com.beyondbit.hibernate.TbQlgkPowerstd;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.hibernate.Session;
import org.hibernate.HibernateException;
import java.util.List;
import java.math.BigDecimal;

public class CommonDao
    extends HibernateDaoSupport
    implements IDao {
    public CommonDao() {
    }

    public synchronized void delPsfileByStepId(final String stepId) {
        this.getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws
                HibernateException {
                session.createQuery(
                    "delete TbQlgkPsfile where fileid in ( select psfid from   TbQlgkStepfile  where sid=" +
                    stepId + ")").executeUpdate();
                session.createQuery(
                    "delete TbQlgkStepfile where sid=" +
                    stepId).executeUpdate();

                return null;
            }
        }

        , true);
//

    }

    /**
     * delPsfile
     *
     * @param stepid String
     */
    public void delPsfile(String psfileid) {
        Object o;
        try {

            o = this.getHibernateTemplate().load(TbQlgkPsfile.class,
                                                 new Integer(psfileid));

            this.getHibernateTemplate().delete(o);

        }
        catch (DataAccessException ex) {
            ex.printStackTrace();
        }

//        this.getHibernateTemplate().dedelete();
    }

    /**
     * loadPsfile
     *
     * @param id String
     */
    public TbQlgkPsfile loadPsfile(String psfileid) {
        TbQlgkPsfile file = (TbQlgkPsfile)this.getHibernateTemplate().load(
            TbQlgkPsfile.class,
            new Integer(psfileid));
        file.getDes();
        return file;
    }

    /**
     * savePsfile
     *
     * @param file TbQlgkPsfile
     */
    public void savePsfile(TbQlgkPsfile file) {
        if (file.getFileid() == null || file.getFileid().intValue() == 0) {
            this.getHibernateTemplate().save(file);
        }
        else {
            this.getHibernateTemplate().update(file);
        }
    }

    /**
     * saveStep
     *
     * @param step TbQlgkPowerstdstep
     */
    public void saveStep(TbQlgkPowerstdstep step) {
        if (step.getStepid() == null || step.getStepid().intValue()==0 ) {
            this.getHibernateTemplate().save(step);
        }
        else {
            this.getHibernateTemplate().update(step);
        }
    }

    /**
     * saveStepfile
     *
     * @param stepfile TbQlgkStepfile
     */
    public void saveStepfile(TbQlgkStepfile stepfile) {
        if (stepfile.getSfid() == null && stepfile.getSfid().intValue() == 0 ) {
            this.getHibernateTemplate().save(stepfile);
        }
        else {
            this.getHibernateTemplate().update(stepfile);
        }
    }

    /**
     * loadStepfile
     *
     * @param stepid String
     * @return TbQlgkStepfile
     */
    public TbQlgkStepfile loadStepfile(String stepid) {
        return (TbQlgkStepfile)this.getHibernateTemplate().load(TbQlgkStepfile.class,
            new Integer(stepid));
    }

    /**
     * loadStep
     *
     * @param id String
     * @return TbQlgkPowerstdstep
     */
    public TbQlgkPowerstdstep loadStep(String stepid) {
        return (TbQlgkPowerstdstep)this.getHibernateTemplate().load(
            TbQlgkPowerstdstep.class,
            new Integer(stepid));
    }

    /**
     * loadSubpowerstd
     *
     * @param id String
     * @return TbQlgkSubpowerstd
     */
    public TbQlgkSubpowerstd loadSubpowerstd(String id) {
        TbQlgkSubpowerstd substd = (TbQlgkSubpowerstd)this.getHibernateTemplate().
            load(TbQlgkSubpowerstd.class,
                 new Integer(id));
        substd.getTbQlgkPowerstdsteps().contains(new Object());
        return substd;
    }

    /**
     * loadLaw
     *
     * @param id String
     * @return TbQlgkLaw
     */
    public TbQlgkLaw loadLaw(String id) {
        TbQlgkLaw law = (TbQlgkLaw)this.getHibernateTemplate().load(
            TbQlgkLaw.class,
            new Integer(id));
        law.getLawbasic();
        return law;
    }

    /**
     * saveLaw
     *
     * @param law TbQlgkLaw
     */
    public void saveLaw(TbQlgkLaw law) {
        if (law.getId() == null || law.getId().intValue() == 0) {
            this.getHibernateTemplate().save(law);
        }
        else {
            this.getHibernateTemplate().update(law);
        }

    }

    /**
     * loadPowerstd
     *
     * @param id String
     * @return TbQlgkPowerstd
     */
    public TbQlgkPowerstd loadPowerstd(String id) {
        TbQlgkPowerstd std = (TbQlgkPowerstd)this.getHibernateTemplate().load(
            TbQlgkPowerstd.class,
            new Integer(id));
        std.getPsname();
        std.getDiagrampicldata();
        std.getDiagrampicsdata();
        return std;

    }

    /**
     * saveStd
     *
     * @param std TbQlgkPowerstd
     */
    public void saveStd(TbQlgkPowerstd std) {
        if (std.getPsid() == null || std.getPsid().intValue() == 0 ) {
            this.getHibernateTemplate().save(std);
        }
        else {
            this.getHibernateTemplate().update(std);
        }

    }

    /**
     * listStepFiles
     *
     * @param stepId String
     * @return List
     */
    public List listStepFiles(String stepId) {
        return this.getHibernateTemplate().findByNamedParam(" select a from TbQlgkPsfile as a,TbQlgkStepfile as b where b.sid=:stepId and b.psfid=a.fileid",
            "stepId", new BigDecimal(stepId));

    }

    /**
     * listPsFiles
     *
     * @param psId String
     * @return List
     */
    public List listPsFiles(String psId) {
        return this.getHibernateTemplate().findByNamedParam(
            " from TbQlgkPsfile where psid=:psid",
            "psid", new BigDecimal(psId));
    }

    /**
     * saveSubstd
     *
     * @param substd TbQlgkSubpowerstd
     */
    public void saveSubstd(TbQlgkSubpowerstd substd) {
        if (substd.getId() == null || "0".equals(substd.getId().toString())) {
//            System.out.println("ÐÂ½¨Á¢commondao");
            this.getHibernateTemplate().save(substd);
        }
        else {
            this.getHibernateTemplate().update(substd);
        }
    }

    /**
     * delSubstd
     *
     * @param substdid String
     */
    public void delSubstd(String substdid) {
        Object o;
        try {

            o = this.getHibernateTemplate().load(com.beyondbit.hibernate.TbQlgkSubpowerstd.class,
                                                 new Integer(substdid));

            this.getHibernateTemplate().delete(o);

        }
        catch (DataAccessException ex) {
            ex.printStackTrace();
        }

    }
}

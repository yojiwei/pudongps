/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.service.web;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


/**
 * @author chenjq
 * Date 2006-7-21 <br>
 * Description: <br>
 * 
 */
public abstract class TreeWeb {
    
    public String sjDir = "";
    public String baseUrl = "";
    public String sjLayer = "";
    public String parDir = "";
    public Connection con = null;
    public Statement stmt = null;
    public ResultSet rs = null;
    
    public String createTree() {
        return "";
    }

    public String getBaseUrl() {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public String getParDir() {
        return parDir;
    }

    public void setParDir(String parDir) {
        this.parDir = parDir;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }

    public String getSjDir() {
        return sjDir;
    }

    public void setSjDir(String sjDir) {
        this.sjDir = sjDir;
    }

    public String getSjLayer() {
        return sjLayer;
    }

    public void setSjLayer(String sjLayer) {
        this.sjLayer = sjLayer;
    }

    public Statement getStmt() {
        return stmt;
    }

    public void setStmt(Statement stmt) {
        this.stmt = stmt;
    }
}

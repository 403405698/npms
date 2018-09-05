package com.yy.young.pms.service;

import com.yy.young.pms.model.Communication;

import java.util.List;

/**
 * 字典服务
 * Created by rookie on 2018/4/5.
 */
public interface IDictionaryService {
    /**
     * 查询字典目录
     * @return
     * @throws Exception
     */
    List<Communication> getDictionaryCatalog() throws Exception;
}

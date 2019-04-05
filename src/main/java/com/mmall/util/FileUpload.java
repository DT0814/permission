package com.mmall.util;/**
 * Created by doter on 2017/7/26.
 */

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;


/**
 * \* Created with IntelliJ IDEA.
 * \* User: doter
 * \* Date: 2017/7/26
 * \* Time: 12:20
 * \* To change this template use File | Settings | File Templates.
 * \* Description:
 * \
 */
public class FileUpload {
        public static final String FILE_PATH = "/upload/";
        static Logger logger = Logger.getLogger("FileUpload");
    /**
     * 文件上传
     * @param file 文件
     * @param middlePath 文件的文件夹
     * @param request
     * @return
     * @throws IOException
     */
        public static String uploadFile(MultipartFile file,String middlePath , HttpServletRequest request) throws IOException {
            String fileName = file.getOriginalFilename();
            UUID randname = UUID.randomUUID();
            String newFileName =randname+fileName.substring(fileName.lastIndexOf("."));
            System.out.println("********NewFile:"+newFileName+"********");
            logger.info("NewFile:"+newFileName);
            String path = request.getSession().getServletContext().getRealPath(middlePath);
            File tempFile = new File(path,newFileName);
            logger.info("NewFile:"+tempFile);
            if (!tempFile.getParentFile().exists()) {
                tempFile.getParentFile().mkdir();
            }
            if (!tempFile.exists()) {
                tempFile.createNewFile();

            }
            file.transferTo(tempFile);
            System.out.println("randname:"+randname);
            System.out.println("inputFilePath:"+path+newFileName);
            System.out.println("outFilePath:"+path+randname+"."+"pdf");
            OfficePDF.openOffice2Pdf(path+newFileName, path+randname+"."+"pdf");
            return middlePath+newFileName;
        }

        public static File getFile(String fileName) {
            return new File(FILE_PATH, fileName);
        }
}

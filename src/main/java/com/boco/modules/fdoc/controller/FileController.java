package com.boco.modules.fdoc.controller;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.boco.common.utils.FTPUtils;
import com.boco.common.utils.PropertiesUtils;
import com.boco.common.utils.StringUtils;

import net.coobird.thumbnailator.Thumbnails;





  /** 
     * 使用SpringMVC封装好的方法进行文件上传 
     * @param request 
     * @param response 
     * @throws IllegalStateException 
     * @throws IOException 
     */  
 
@Controller()
public class FileController {
	@RequestMapping(value = "/test/upload1")
	public String addFile(@RequestParam(value="file",required=false) MultipartFile file, HttpServletRequest request, ModelMap model)
			throws IOException {
		//获取解析器  
        CommonsMultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断是否是文件  
        if(resolver.isMultipart(request)){  
            //进行转换  
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)(request);  
            //获取所有文件名称  
            Iterator<String> it = multiRequest.getFileNames();  
            while(it.hasNext()){  
                //根据文件名称取文件  
                MultipartFile file1 = multiRequest.getFile(it.next());  
                String fileName = file1.getOriginalFilename();  
                String localPath = "E:/temp/" + fileName;  
                File headPath = new File("E:/temp/");//获取文件夹路径
                if(!headPath.exists()){//判断文件夹是否创建，没有创建则创建新文件夹
                	headPath.mkdirs();
                }
                File newFile = new File(localPath);  
                //上传的文件写入到指定的文件中  
                file1.transferTo(newFile);  
                
                //图片缩放
                Image smallImg = ImageIO.read(newFile);
                int newWidth = 86; 
                int newHeight = 100; 
                BufferedImage tag = new BufferedImage((int) newWidth, (int) newHeight, BufferedImage.TYPE_INT_RGB);  
                
                tag.getGraphics().drawImage(smallImg.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH), 0, 0, null);  
                FileOutputStream out = new FileOutputStream("E:/temp/" + "small_"+fileName);  
                // JPEGImageEncoder可适用于其他图片类型的转换   
               // JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);   
               // encoder.encode(tag);
                out.close(); 
            }  
        }  
        return "success";
	}
	
	/**
	 * 缩略图上传
	 * @param img
	 * @param request
	 * @param session
	 * @return
	 *
	 */
	@RequestMapping(value = "/test/upload", method = RequestMethod.POST)
	public String uploadImage(MultipartFile img,HttpServletRequest request,HttpSession session){
	//	System.out.println("+++++++++++++++"+img.getOriginalFilename());
		try {
			if (img != null && img.getOriginalFilename() != null && StringUtils.isNotEmpty(img.getOriginalFilename())) {
				
				InputStream is = img.getInputStream();
				
				byte[] bs = new byte[1024];  
		        int len;
				// 生成jpeg图片
				String headSuffix = StringUtils.getSuffix(img.getOriginalFilename()); // 获取后缀名
				String signImgHeadName = UUID.randomUUID().toString()
						.substring(0, 8)
						+ "." + headSuffix; // 重命名为8位随机数
				
				//复制文件到指定路径 
				File saveFile = new File((request.getContextPath() + "/upload/personImg/" + signImgHeadName).substring(6)); 
				FileUtils.copyInputStreamToFile(is, saveFile); 
		        //上传文件到服务器 
				FTPUtils.upload(saveFile, "/upload/personImg/"); 
		        //得到文件服务器地址
				String ip =PropertiesUtils.getValue("ftp_server_ip");
				
				session.setAttribute("url", "ftp://"+ip+(request.getContextPath() + "/upload/personImg/" + signImgHeadName).substring(5));
		        //entity.setImg((request.getContextPath() + "/upload/img/"
					//	+ signImgHeadName).substring(9));
				//把上传图片存储起来，用于截取
				session.setAttribute("MultipartFile", img);
				
				
				//制作缩略图
				//复制文件到指定路径 
				File saveThumFile = new File((request.getContextPath() + "/upload/personImg/" + "thum_"+signImgHeadName).substring(6)); 
				Thumbnails.of(img.getInputStream()).size(120, 123).toFile(saveThumFile);
				
		        //上传文件到服务器 
				FTPUtils.upload(saveThumFile, "/upload/personImg/"); 
						 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return "success";
	}
}
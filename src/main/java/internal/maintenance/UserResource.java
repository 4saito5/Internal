package internal.maintenance;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import internal.common.DbBase;

@Path("mt")
public class UserResource extends DbBase {
  static private Logger logger = LogManager.getLogger(UserResource.class);

  /**
   * getUserList.<br>
   *<br>
   * @param reqBody リクエストボディ
   * @return 結果
   */
  @Path("getUserList")
  @GET
  @Produces(MediaType.TEXT_PLAIN)
  public String getUserList() {
    Map<String, Object> resMap = new HashMap<>();
    SqlSession session = null;

    try {
      // SqlSessionFactoryからSqlSessionを生成する
      session = getSqlSessionFactory().openSession();
      if (session != null) {

        // ユーザーリスト取得
        // SQL実行
        List<Map<String, Object>> resultUserList =
                session.selectList("user.mybatis.getUserList");
        resMap.put("userList", resultUserList);

        resMap.put("result", 0);
      }

    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      resMap.put("result", 1);
    } finally {
      if (session != null) {
        session.close();
      }
    }

    final Gson outJson = new GsonBuilder().serializeNulls().create();
    logger.trace(outJson.toJson(resMap));
    return outJson.toJson(resMap);
  }

  /**
   * getUser.<br>
   *<br>
   * @param reqBody リクエストボディ
   * @return 結果
   */
  @Path("getUser")
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.TEXT_PLAIN)
  public String getUser(String reqBody) {
    logger.trace("reqBody:" + reqBody);
    Map<String, Object> resMap = new HashMap<>();
    SqlSession session = null;

    try {
        // inパラメータの取得
        Type type = new TypeToken<Map<String, Object>>(){}.getType();
        Gson gson = new Gson();
        Map<String, Object> map = gson.fromJson(reqBody, type);

        String user_id = map.get("user_id").toString();

    	// SqlSessionFactoryからSqlSessionを生成する
      session = getSqlSessionFactory().openSession();
      if (session != null) {

        // ユーザー取得
        // Mapでパラメータを渡す
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", user_id);

        // SQL実行
        Map<String, Object> resultUser =
            session.selectOne("user.mybatis.getUser", param);

        if (resultUser == null) {
          throw new ServletException("ユーザーデータなし");
        }
        // resultUser.remove("password");
        resMap.put("user", resultUser);

        // 連絡先取得
        // SQL実行
        List<Map<String, Object>> resultContact =
                session.selectList("user.mybatis.getContact", param);
        resMap.put("contact", resultContact);

        // コード取得
        // 権限種別
        param.clear();
        param.put("name", "ATH");
        // SQL実行
        List<Map<String, Object>> resultAth =
                session.selectList("code.mybatis.getCode", param);
        resMap.put("athList", resultAth);

        // 連絡種別
        param.clear();
        param.put("name", "CNT");
        // SQL実行
        List<Map<String, Object>> resultCnt =
                session.selectList("code.mybatis.getCode", param);
        resMap.put("cntList", resultCnt);

        resMap.put("result", 0);
      }

    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      resMap.put("result", 1);
    } finally {
      if (session != null) {
        session.close();
      }
    }

    final Gson outJson = new GsonBuilder().serializeNulls().create();
    logger.trace(outJson.toJson(resMap));
    return outJson.toJson(resMap);
  }
}

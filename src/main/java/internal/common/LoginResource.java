package internal.common;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.ws.rs.Consumes;
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

@Path("login")
public class LoginResource extends DbBase {
  static private Logger logger = LogManager.getLogger(LoginResource.class);

  /**
   * login.<br>
   *<br>
   * @param reqBody リクエストボディ
   * @return 結果
   */
  @POST
  // @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.TEXT_PLAIN)
  public String login(String reqBody) {
    logger.trace("reqBody:" + reqBody);
    Map<String, Object> resMap = new HashMap<>();
    SqlSession session = null;

    try {
      // inパラメータの取得
      Type type = new TypeToken<Map<String, Object>>(){}.getType();
      Gson gson = new Gson();
      Map<String, Object> map = gson.fromJson(reqBody, type);

      String login_id = map.get("login_id").toString();
      String password = map.get("password").toString();

      // SqlSessionFactoryからSqlSessionを生成する
      session = getSqlSessionFactory().openSession();
      if (session != null) {

        // ユーザー取得
        // Mapでパラメータを渡す
        Map<String, Object> param = new HashMap<>();
        param.put("login_id", login_id);
        param.put("password", password);

        // SQL実行
        Map<String, Object> resultUser =
            session.selectOne("login.mybatis.getUser", param);

        if (resultUser == null) {
          throw new ServletException("ログインデータなし");
        }
        // resultUser.remove("password");
        resMap.put("user", resultUser);

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

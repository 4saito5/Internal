/*
 * プログラム名：サーバークラスの基底クラス<br>
 *<br>
 * 作成者  ：s.saito<br>
 */

package internal.common;

import java.io.InputStream;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class DbBase {
  static private SqlSessionFactory factory;

  /**
   * getter.<br>
   *<br>
   * @return SqlSessionFactory
   */
  static public SqlSessionFactory getSqlSessionFactory() {
    return factory;
  }

  /**
   * コンストラクタ.<br>
   *<br>
   */
  public DbBase() {
    factory = _getSqlSessionFactory();
  }

  /**
   * SqlSessionFactory取得.<br>
   *<br>
   * @return SqlSessionFactory
   */
   private SqlSessionFactory _getSqlSessionFactory() {
    Logger logger = LogManager.getLogger(LoginResource.class);

    // ルートとなる設定ファイルを読み込む
    try (InputStream in = DbBase.class.getResourceAsStream("/mybatis-config.xml") ) {
      // 設定ファイルを元に、SqlSessionFactoryを作成する
      SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
      return factory;
    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      e.printStackTrace();
    }
    return null;
  }
}

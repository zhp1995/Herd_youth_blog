package cn.tjz.util;
import redis.clients.jedis.*;
import java.util.LinkedList;
import java.util.List;
/**
 * redis连接池
 * @author tjz
 *
 */
public class MyShardedJedisPool {

    private static ShardedJedisPool shardedJedisPool;

    // 静态代码初始化池配置
    static {
       
        JedisPoolConfig config = new JedisPoolConfig();
        //控制一个pool最多有多少个状态为idle(空闲的)的jedis实例。
        config.setMaxIdle(5);
        //控制一个pool可分配多少个jedis实例，通过pool.getResource()来获取；
        //如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
        //在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
        config.setMaxTotal(-1);
        //表示当borrow(引入)一个jedis实例时，最大的等待时间，如果超过等待时间，则直接抛出JedisConnectionException；
        config.setMaxWaitMillis(5);
        config.setTestOnBorrow(true);
        config.setTestOnReturn(true);
        //创建四个redis服务实例，并封装在list中
        List<JedisShardInfo> list = new LinkedList<JedisShardInfo>();
        list.add(new JedisShardInfo("127.0.0.1", 6379));
        //创建具有分片功能的的Jedis连接池
        shardedJedisPool = new ShardedJedisPool(config, list);
    }

    // 获取连接池
    public static ShardedJedis getShardedJedis() {
        return shardedJedisPool.getResource();
    }

   
}

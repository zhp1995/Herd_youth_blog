package cn.tjz.exception;
/**
 * 平台基础异常
 * @author tjz
 *
 */
public class BlogException extends RuntimeException {
	private static final long serialVersionUID = 7428372075170298879L;

	public BlogException() {
	}

	public BlogException(String message) {
		super(message);
	}

	public BlogException(Throwable cause) {
		super(cause);
	}

	public BlogException(String message, Throwable cause) {
		super(message, cause);
	}

	public BlogException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}
}

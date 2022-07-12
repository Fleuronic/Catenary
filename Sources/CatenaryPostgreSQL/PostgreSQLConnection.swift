// Copyright © Fleuronic LLC. All rights reserved.

import Catenary
import PostgresKit

public struct PostgreSQLConnection {
	private let eventLoopGroup: MultiThreadedEventLoopGroup
	private let pool: EventLoopGroupConnectionPool<PostgresConnectionSource>
}

// MARK: -
public extension PostgreSQLConnection {
	init(
		hostName: String,
		username: String,
		database: String
	) {
		eventLoopGroup = .init(numberOfThreads: 1)
		pool = .init(
			source: .init(
				configuration:  .init(
					hostname: hostName,
					username: username,
					database: database
				)
			),
			on: eventLoopGroup
		)
	}
}

// MARK: -
extension PostgreSQLConnection: Connection {
	public typealias Database = SQLDatabase

	public func open() -> SQLDatabase {
		pool.database(logger: .init(label: .logger)).sql()
	}

	public func close() throws {
		try eventLoopGroup.syncShutdownGracefully()
		pool.shutdown()
	}
}

// MARK: -
private extension String {
	static let logger = "logger"
}

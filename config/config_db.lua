DB = {
    new = true,         -- Remove the previous database and create a new one
    backtrace = false,   -- Show warnings, errors, and information messages
    DEBUG = false,       -- Show SQL queries
    type = "sqlite3",   -- Database type (can be "mysql", "postgresql", or "sqlite3")
    name = "/www/database.db",  -- Database name or path to the SQLite3 file
    username = nil,     -- Database username (for MySQL or PostgreSQL)
    password = nil,     -- Database password (for MySQL or PostgreSQL)
    host = nil,         -- Database host (for MySQL or PostgreSQL)
    port = nil          -- Database host port (for MySQL or PostgreSQL)
}


return DB
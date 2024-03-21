import unittest
import mysql.connector

class TestStateCreation(unittest.TestCase):
    def setUp(self):
        # Connect to your MySQL test database
        self.conn = mysql.connector.connect(
            host='localhost',
            user='your_username',
            password='your_password',
            database='your_test_database'
        )
        self.cursor = self.conn.cursor()

    def tearDown(self):
        # Close database connection after each test
        self.cursor.close()
        self.conn.close()

    def test_state_creation(self):
        # Get the initial number of records in the states table
        self.cursor.execute("SELECT COUNT(*) FROM states")
        initial_count = self.cursor.fetchone()[0]

        # Execute the console command (assuming it's an SQL query)
        self.cursor.execute("INSERT INTO states (name) VALUES ('California')")

        # Get the number of records after executing the command
        self.cursor.execute("SELECT COUNT(*) FROM states")
        final_count = self.cursor.fetchone()[0]

        # Check if the difference is +1
        self.assertEqual(final_count - initial_count, 1, "State creation test failed")


if __name__ == '__main__':
    unittest.main()

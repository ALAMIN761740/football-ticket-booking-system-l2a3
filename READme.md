# ⚽ Football Ticket Booking System


## 📎 Submission Links (fill before submitting)
- ERD public link:(https://app.diagrams.net/?utm_source=chatgpt.com#G1mmK6MbfprrJb31Lfz9x5kj1T61vy1DTw#%7B%22pageId%22%3A%22id0QN1zqxy0xKjJY8VQb%22%7D)

- GitHub repository link: ___________________________
- Interview video link (YouTube unlisted / Google Drive): __________________

Please paste the final public links above before you submit to ensure graders can access all deliverables.




## 📌 Project Description
This project is a simple Football Ticket Booking System database built using PostgreSQL.  
It manages users, football matches, and ticket bookings with proper relationships between tables.

---

## 🗄️ Database Name
football_ticket_booking_db

---

## 🧱 Tables

### Users
- user_id (Primary Key)
- full_name
# ⚽ Football Ticket Booking System



## 📌 Short Project Note
The database schema, sample data and the seven required SQL queries are provided in `QUERY.sql`. The ERD preview is in `ERD/football-ticket-booking.drawio.png`.

## ▶️ Quick Run (Postgres)
```bash
createdb football_ticket_booking_db
psql -d football_ticket_booking_db -f QUERY.sql
```

If everything above is filled and the ERD/video links are public, your submission matches the assignment requirements and no further changes are needed.

If you'd like, I can run the queries and paste the result rows here or create screenshots of outputs.
## 🔗 Relationships

- One User can have many Bookings

- One Match can have many Bookings

- Bookings table connects Users and Matches

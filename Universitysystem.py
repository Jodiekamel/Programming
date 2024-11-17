# File: university_management_system.py

import tkinter as tk
from tkinter import ttk, messagebox
import sqlite3


class UniversityApp:
    def __init__(self, root):
        self.root = root
        self.root.title("University Management System")
        self.root.geometry("800x600")

        # Database setup
        self.setup_database()

        # Tab setup
        self.notebook = ttk.Notebook(root)
        self.notebook.pack(fill='both', expand=True)

        self.create_students_tab()
        self.create_courses_tab()
        self.create_professors_tab()
        self.create_enrollments_tab()

    def setup_database(self):
        self.conn = sqlite3.connect("university.db")
        self.cursor = self.conn.cursor()

        # Create tables
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS students (
                student_id TEXT PRIMARY KEY,
                name TEXT NOT NULL
            )
        """)
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS professors (
                professor_id TEXT PRIMARY KEY,
                name TEXT NOT NULL
            )
        """)
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS courses (
                course_id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                professor_id TEXT NOT NULL,
                FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
            )
        """)
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS enrollments (
                enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
                student_id TEXT NOT NULL,
                course_id TEXT NOT NULL,
                FOREIGN KEY (student_id) REFERENCES students(student_id),
                FOREIGN KEY (course_id) REFERENCES courses(course_id)
            )
        """)
        self.conn.commit()

    def create_students_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="Students")

        # Form to add students
        ttk.Label(frame, text="Student ID:").grid(row=0, column=0, padx=5, pady=5)
        self.student_id_entry = ttk.Entry(frame)
        self.student_id_entry.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(frame, text="Name:").grid(row=1, column=0, padx=5, pady=5)
        self.student_name_entry = ttk.Entry(frame)
        self.student_name_entry.grid(row=1, column=1, padx=5, pady=5)

        ttk.Button(frame, text="Add Student", command=self.add_student).grid(row=2, column=0, columnspan=2, pady=10)

        # Table to display students
        self.students_table = ttk.Treeview(frame, columns=("ID", "Name"), show="headings")
        self.students_table.heading("ID", text="Student ID")
        self.students_table.heading("Name", text="Name")
        self.students_table.grid(row=3, column=0, columnspan=2, pady=10)
        self.refresh_students_table()

    def add_student(self):
        student_id = self.student_id_entry.get().strip()
        name = self.student_name_entry.get().strip()

        if not student_id or not name:
            messagebox.showerror("Error", "All fields are required.")
            return

        try:
            self.cursor.execute("INSERT INTO students (student_id, name) VALUES (?, ?)", (student_id, name))
            self.conn.commit()
            self.refresh_students_table()
            messagebox.showinfo("Success", "Student added successfully!")
        except sqlite3.IntegrityError:
            messagebox.showerror("Error", "Student ID already exists.")

    def refresh_students_table(self):
        for row in self.students_table.get_children():
            self.students_table.delete(row)

        self.cursor.execute("SELECT student_id, name FROM students")
        for row in self.cursor.fetchall():
            self.students_table.insert("", tk.END, values=row)

    def create_courses_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="Courses")

        # Form to add courses
        ttk.Label(frame, text="Course ID:").grid(row=0, column=0, padx=5, pady=5)
        self.course_id_entry = ttk.Entry(frame)
        self.course_id_entry.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(frame, text="Course Name:").grid(row=1, column=0, padx=5, pady=5)
        self.course_name_entry = ttk.Entry(frame)
        self.course_name_entry.grid(row=1, column=1, padx=5, pady=5)

        ttk.Label(frame, text="Professor ID:").grid(row=2, column=0, padx=5, pady=5)
        self.course_professor_entry = ttk.Entry(frame)
        self.course_professor_entry.grid(row=2, column=1, padx=5, pady=5)

        ttk.Button(frame, text="Add Course", command=self.add_course).grid(row=3, column=0, columnspan=2, pady=10)

        # Table to display courses
        self.courses_table = ttk.Treeview(frame, columns=("ID", "Name", "Professor"), show="headings")
        self.courses_table.heading("ID", text="Course ID")
        self.courses_table.heading("Name", text="Name")
        self.courses_table.heading("Professor", text="Professor ID")
        self.courses_table.grid(row=4, column=0, columnspan=2, pady=10)
        self.refresh_courses_table()

    def add_course(self):
        course_id = self.course_id_entry.get().strip()
        name = self.course_name_entry.get().strip()
        professor_id = self.course_professor_entry.get().strip()

        if not course_id or not name or not professor_id:
            messagebox.showerror("Error", "All fields are required.")
            return

        try:
            self.cursor.execute(
                "INSERT INTO courses (course_id, name, professor_id) VALUES (?, ?, ?)",
                (course_id, name, professor_id)
            )
            self.conn.commit()
            self.refresh_courses_table()
            messagebox.showinfo("Success", "Course added successfully!")
        except sqlite3.IntegrityError:
            messagebox.showerror("Error", "Course ID already exists or Professor ID does not exist.")

    def refresh_courses_table(self):
        for row in self.courses_table.get_children():
            self.courses_table.delete(row)

        self.cursor.execute("SELECT course_id, name, professor_id FROM courses")
        for row in self.cursor.fetchall():
            self.courses_table.insert("", tk.END, values=row)

    def create_professors_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="Professors")

        # Form to add professors
        ttk.Label(frame, text="Professor ID:").grid(row=0, column=0, padx=5, pady=5)
        self.professor_id_entry = ttk.Entry(frame)
        self.professor_id_entry.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(frame, text="Name:").grid(row=1, column=0, padx=5, pady=5)
        self.professor_name_entry = ttk.Entry(frame)
        self.professor_name_entry.grid(row=1, column=1, padx=5, pady=5)

        ttk.Button(frame, text="Add Professor", command=self.add_professor).grid(row=2, column=0, columnspan=2, pady=10)

        # Table to display professors
        self.professors_table = ttk.Treeview(frame, columns=("ID", "Name"), show="headings")
        self.professors_table.heading("ID", text="Professor ID")
        self.professors_table.heading("Name", text="Name")
        self.professors_table.grid(row=3, column=0, columnspan=2, pady=10)
        self.refresh_professors_table()

    def add_professor(self):
        professor_id = self.professor_id_entry.get().strip()
        name = self.professor_name_entry.get().strip()

        if not professor_id or not name:
            messagebox.showerror("Error", "All fields are required.")
            return

        try:
            self.cursor.execute("INSERT INTO professors (professor_id, name) VALUES (?, ?)", (professor_id, name))
            self.conn.commit()
            self.refresh_professors_table()
            messagebox.showinfo("Success", "Professor added successfully!")
        except sqlite3.IntegrityError:
            messagebox.showerror("Error", "Professor ID already exists.")

    def refresh_professors_table(self):
        for row in self.professors_table.get_children():
            self.professors_table.delete(row)

        self.cursor.execute("SELECT professor_id, name FROM professors")
        for row in self.cursor.fetchall():
            self.professors_table.insert("", tk.END, values=row)

    def create_enrollments_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="Enrollments")

        # Form for enrolling students
        ttk.Label(frame, text="Student ID:").grid(row=0, column=0, padx=5, pady=5)
        self.enroll_student_id_entry = ttk.Entry(frame)
        self.enroll_student_id_entry.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(frame, text="Course ID:").grid(row=1, column=0, padx=5, pady=5)
        self.enroll_course_id_entry = ttk.Entry(frame)
        self.enroll_course_id_entry.grid(row=1, column=1, padx=5, pady=5)

        ttk.Button(frame, text="Enroll", command=self.add_enrollment).grid(row=2, column=0, columnspan=2, pady=10)

        # Table to display enrollments
        self.enrollments_table = ttk.Treeview(frame, columns=("Enrollment ID", "Student ID", "Course ID"), show="headings")
        self.enrollments_table.heading("Enrollment ID", text="Enrollment ID")
        self.enrollments_table.heading("Student ID", text="Student ID")
        self.enrollments_table.heading("Course ID", text="Course ID")
        self.enrollments_table.grid(row=3, column=0, columnspan=2, pady=10)
        self.refresh_enrollments_table()

    def add_enrollment(self):
        student_id = self.enroll_student_id_entry.get().strip()
        course_id = self.enroll_course_id_entry.get().strip()

        if not student_id or not course_id:
            messagebox.showerror("Error", "All fields are required.")
            return

        try:
            self.cursor.execute(
                "INSERT INTO enrollments (student_id, course_id) VALUES (?, ?)",
                (student_id, course_id)
            )
            self.conn.commit()
            self.refresh_enrollments_table()
            messagebox.showinfo("Success", "Enrollment added successfully!")
        except sqlite3.IntegrityError:
            messagebox.showerror("Error", "Invalid Student ID or Course ID.")

    def refresh_enrollments_table(self):
        for row in self.enrollments_table.get_children():
            self.enrollments_table.delete(row)

        self.cursor.execute("SELECT enrollment_id, student_id, course_id FROM enrollments")
        for row in self.cursor.fetchall():
            self.enrollments_table.insert("", tk.END, values=row)

    def __del__(self):
        self.conn.close()


if __name__ == "__main__":
    root = tk.Tk()
    app = UniversityApp(root)
    root.mainloop()
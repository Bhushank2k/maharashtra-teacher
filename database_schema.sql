-- ============================================
-- DATABASE SCHEMA FOR MAHARASHTRA TEACHER
-- Run this in Supabase SQL Editor
-- ============================================

-- Users Table
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  district TEXT,
  experience INT,
  verified BOOLEAN DEFAULT false,
  bio TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Posts Table
CREATE TABLE posts (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Comments Table
CREATE TABLE comments (
  id BIGSERIAL PRIMARY KEY,
  content TEXT NOT NULL,
  post_id BIGINT NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Resources Table
CREATE TABLE resources (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_type TEXT,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  downloads INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE resources ENABLE ROW LEVEL SECURITY;

-- Public Read Policies
CREATE POLICY "Users are viewable by everyone" ON users FOR SELECT USING (true);
CREATE POLICY "Posts are viewable by everyone" ON posts FOR SELECT USING (true);
CREATE POLICY "Comments are viewable by everyone" ON comments FOR SELECT USING (true);
CREATE POLICY "Resources are viewable by everyone" ON resources FOR SELECT USING (true);

-- User Insert Policy (for signup)
CREATE POLICY "Users can insert their own profile" ON users FOR INSERT WITH CHECK (auth.uid() = id);

-- User Update Policy
CREATE POLICY "Users can update their own profile" ON users FOR UPDATE USING (auth.uid() = id);

-- Post Insert Policy
CREATE POLICY "Authenticated users can create posts" ON posts FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Post Delete Policy
CREATE POLICY "Users can delete their own posts" ON posts FOR DELETE USING (auth.uid() = user_id);

-- Comment Insert Policy
CREATE POLICY "Authenticated users can create comments" ON comments FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Comment Delete Policy
CREATE POLICY "Users can delete their own comments" ON comments FOR DELETE USING (auth.uid() = user_id);

-- Resource Insert Policy
CREATE POLICY "Authenticated users can upload resources" ON resources FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Resource Delete Policy
CREATE POLICY "Users can delete their own resources" ON resources FOR DELETE USING (auth.uid() = user_id);

-- Create Indexes for Performance
CREATE INDEX posts_user_id_idx ON posts(user_id);
CREATE INDEX posts_created_at_idx ON posts(created_at DESC);
CREATE INDEX comments_post_id_idx ON comments(post_id);
CREATE INDEX comments_user_id_idx ON comments(user_id);
CREATE INDEX users_district_idx ON users(district);
CREATE INDEX resources_user_id_idx ON resources(user_id);

-- Insert Sample Data (Optional - for testing)
-- Uncomment below to add sample data
/*
INSERT INTO users (id, email, name, district, experience, verified, bio) VALUES
('11111111-1111-1111-1111-111111111111', 'teacher1@example.com', 'Rajesh Kumar', 'Pune', 5, true, 'Computer Science Teacher'),
('22222222-2222-2222-2222-222222222222', 'teacher2@example.com', 'Priya Singh', 'Mumbai', 3, true, 'Physics and Computer Teacher'),
('33333333-3333-3333-3333-333333333333', 'teacher3@example.com', 'Amit Patel', 'Nagpur', 7, true, 'IT and Programming Expert');

INSERT INTO posts (title, content, user_id, created_at) VALUES
('Python Tutorial', 'Learn Python basics in 10 easy steps...', '11111111-1111-1111-1111-111111111111', NOW()),
('Database Design', 'Best practices for database normalization...', '22222222-2222-2222-2222-222222222222', NOW() - INTERVAL '1 day'),
('Web Development Tips', 'Frontend and backend development tips...', '33333333-3333-3333-3333-333333333333', NOW() - INTERVAL '2 days');
*/

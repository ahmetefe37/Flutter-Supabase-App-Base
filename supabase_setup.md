# Supabase Database Setup Guide

This guide provides step-by-step instructions for setting up the database structure and authentication for your Flutter + Supabase project.

## 📋 Prerequisites

- Supabase account created
- Project created in Supabase dashboard
- Project URL and anon key obtained

## 🚀 Quick Setup

### Step 1: Authentication Configuration

1. Go to **Authentication > Settings** in your Supabase dashboard
2. Configure the following:

**Site URL:**

```
http://localhost:3000
```

**Redirect URLs:**

```
http://localhost:3000/**
https://yourdomain.com/**
```

**Email Templates:** Review and customize as needed

### Step 2: Database Tables Creation

#### Create Profiles Table

Go to **SQL Editor** and run:

```sql
-- Create profiles table
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT,
  name TEXT,
  avatar_url TEXT,
  phone TEXT,
  bio TEXT,
  website TEXT,
  location TEXT,
  birth_date DATE,
  is_active BOOLEAN DEFAULT true,
  preferences JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Add indexes for better performance
CREATE INDEX profiles_email_idx ON public.profiles(email);
CREATE INDEX profiles_name_idx ON public.profiles(name);
CREATE INDEX profiles_created_at_idx ON public.profiles(created_at);
```

#### Alternative: Create via Table Editor UI

1. **Table Editor > Create a new table**
2. **Table name**: `profiles`
3. **Add columns:**

| Column Name | Type        | Default | Nullable | Primary Key | Foreign Key    |
| ----------- | ----------- | ------- | -------- | ----------- | -------------- |
| id          | uuid        | -       | No       | Yes         | auth.users(id) |
| email       | text        | -       | Yes      | No          | -              |
| name        | text        | -       | Yes      | No          | -              |
| avatar_url  | text        | -       | Yes      | No          | -              |
| phone       | text        | -       | Yes      | No          | -              |
| bio         | text        | -       | Yes      | No          | -              |
| website     | text        | -       | Yes      | No          | -              |
| location    | text        | -       | Yes      | No          | -              |
| birth_date  | date        | -       | Yes      | No          | -              |
| is_active   | bool        | true    | No       | No          | -              |
| preferences | jsonb       | {}      | Yes      | No          | -              |
| created_at  | timestamptz | now()   | No       | No          | -              |
| updated_at  | timestamptz | now()   | No       | No          | -              |

### Step 3: Row Level Security (RLS)

```sql
-- Enable RLS on profiles table
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their own profile
CREATE POLICY "Users can view their own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

-- Policy: Users can update their own profile
CREATE POLICY "Users can update their own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- Policy: Users can insert their own profile
CREATE POLICY "Users can insert their own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Policy: Users can delete their own profile
CREATE POLICY "Users can delete their own profile" ON public.profiles
  FOR DELETE USING (auth.uid() = id);

-- Optional: Public profiles policy (if you want profiles to be publicly viewable)
CREATE POLICY "Public profiles are viewable by everyone" ON public.profiles
  FOR SELECT USING (is_active = true);
```

### Step 4: Database Functions

#### Auto-create Profile Function

```sql
-- Function to handle new user profile creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'name', NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to automatically create profile on user signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

#### Update Timestamp Function

```sql
-- Function to handle updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update updated_at column
CREATE TRIGGER handle_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
```

#### Get User Profile Function

```sql
-- Function to get user profile with additional data
CREATE OR REPLACE FUNCTION public.get_user_profile(user_id UUID)
RETURNS TABLE (
  id UUID,
  email TEXT,
  name TEXT,
  avatar_url TEXT,
  phone TEXT,
  bio TEXT,
  website TEXT,
  location TEXT,
  birth_date DATE,
  is_active BOOLEAN,
  preferences JSONB,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ,
  last_sign_in_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.id,
    p.email,
    p.name,
    p.avatar_url,
    p.phone,
    p.bio,
    p.website,
    p.location,
    p.birth_date,
    p.is_active,
    p.preferences,
    p.created_at,
    p.updated_at,
    u.last_sign_in_at
  FROM public.profiles p
  LEFT JOIN auth.users u ON p.id = u.id
  WHERE p.id = user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### Step 5: Storage Buckets

#### Create Avatars Bucket

1. Go to **Storage** in dashboard
2. Click **"Create bucket"**
3. **Bucket name**: `avatars`
4. **Public**: ✅ Enabled
5. Click **"Create bucket"**

#### Create Files Bucket

1. Click **"Create bucket"**
2. **Bucket name**: `files`
3. **Public**: ❌ Disabled (for private files)
4. Click **"Create bucket"**

### Step 6: Storage Policies

```sql
-- Avatars bucket policies
CREATE POLICY "Users can upload their own avatar" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can update their own avatar" ON storage.objects
  FOR UPDATE USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete their own avatar" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Anyone can view avatars" ON storage.objects
  FOR SELECT USING (bucket_id = 'avatars');

-- Files bucket policies
CREATE POLICY "Users can upload their own files" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'files'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can view their own files" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'files'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can update their own files" ON storage.objects
  FOR UPDATE USING (
    bucket_id = 'files'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete their own files" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'files'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );
```

### Step 7: Additional Tables (Optional)

#### User Settings Table

```sql
-- Create user settings table
CREATE TABLE public.user_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  theme_mode TEXT DEFAULT 'system' CHECK (theme_mode IN ('light', 'dark', 'system')),
  language TEXT DEFAULT 'en' CHECK (language IN ('en', 'tr', 'es', 'fr', 'de')),
  notifications_enabled BOOLEAN DEFAULT true,
  email_notifications BOOLEAN DEFAULT true,
  push_notifications BOOLEAN DEFAULT true,
  marketing_emails BOOLEAN DEFAULT false,
  two_factor_enabled BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can manage their own settings" ON public.user_settings
  FOR ALL USING (auth.uid() = user_id);

-- Trigger for updated_at
CREATE TRIGGER handle_user_settings_updated_at
  BEFORE UPDATE ON public.user_settings
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- Function to create default settings
CREATE OR REPLACE FUNCTION public.create_user_settings()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_settings (user_id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create settings on user creation
CREATE TRIGGER on_user_settings_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.create_user_settings();
```

#### User Activity Log Table

```sql
-- Create user activity log table
CREATE TABLE public.user_activity_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  action TEXT NOT NULL,
  details JSONB DEFAULT '{}',
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.user_activity_log ENABLE ROW LEVEL SECURITY;

-- RLS Policy
CREATE POLICY "Users can view their own activity log" ON public.user_activity_log
  FOR SELECT USING (auth.uid() = user_id);

-- Indexes for better performance
CREATE INDEX user_activity_log_user_id_idx ON public.user_activity_log(user_id);
CREATE INDEX user_activity_log_created_at_idx ON public.user_activity_log(created_at);
CREATE INDEX user_activity_log_action_idx ON public.user_activity_log(action);
```

### Step 8: Real-time Setup

Enable real-time for tables you want to listen to changes:

```sql
-- Enable real-time for profiles table
ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;

-- Enable real-time for user_settings table
ALTER PUBLICATION supabase_realtime ADD TABLE public.user_settings;
```

### Step 9: Database Views (Optional)

```sql
-- Create a view for user profile with auth data
CREATE VIEW public.user_profiles_view AS
SELECT
  p.id,
  p.email,
  p.name,
  p.avatar_url,
  p.phone,
  p.bio,
  p.website,
  p.location,
  p.birth_date,
  p.is_active,
  p.preferences,
  p.created_at,
  p.updated_at,
  u.last_sign_in_at,
  u.email_confirmed_at,
  s.theme_mode,
  s.language,
  s.notifications_enabled
FROM public.profiles p
LEFT JOIN auth.users u ON p.id = u.id
LEFT JOIN public.user_settings s ON p.id = s.user_id;

-- Grant access to the view
GRANT SELECT ON public.user_profiles_view TO authenticated;
```

### Step 10: Database Extensions

Enable useful PostgreSQL extensions:

```sql
-- Enable UUID extension (usually already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable crypto extension for advanced encryption
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Enable full-text search
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Enable unaccent for better text search
CREATE EXTENSION IF NOT EXISTS "unaccent";
```

## 🧪 Testing Your Setup

### Test Authentication

1. Go to **Authentication > Users**
2. Create a test user manually or use your app
3. Check if profile is auto-created in **Table Editor > profiles**

### Test Storage

1. Try uploading a file through the Supabase dashboard
2. Check if policies work correctly

### Test RLS

Run these queries in **SQL Editor** to test:

```sql
-- This should only return the current user's profile
SELECT * FROM public.profiles;

-- This should work if you're authenticated
INSERT INTO public.profiles (id, name) VALUES (auth.uid(), 'Test Name');
```

## 🔧 Troubleshooting

### Common Issues

**Problem**: Profile not created automatically

```sql
-- Check if trigger exists
SELECT * FROM information_schema.triggers WHERE trigger_name = 'on_auth_user_created';

-- Recreate if missing
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

**Problem**: RLS blocking queries

```sql
-- Check policies
SELECT * FROM pg_policies WHERE tablename = 'profiles';

-- Temporarily disable RLS for testing (NOT recommended for production)
ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;
```

**Problem**: Storage upload fails

```sql
-- Check storage policies
SELECT * FROM storage.policies;

-- Recreate storage policies if needed
```

## 📚 Best Practices

1. **Always enable RLS** on user-related tables
2. **Use meaningful policy names** that describe what they do
3. **Test policies thoroughly** before deploying
4. **Keep backups** of your database schema
5. **Use transactions** for related operations
6. **Monitor performance** with indexes
7. **Regularly update statistics** for optimal query performance

## 🚀 Next Steps

After completing this setup:

1. Update your Flutter app's `.env` file with correct Supabase credentials
2. Test authentication flow in your app
3. Test profile creation and updates
4. Test file upload functionality
5. Implement additional features as needed

## 📝 Schema Backup

Save this complete schema setup:

```sql
-- Complete database setup script
-- Run this to recreate the entire structure

-- [Include all the SQL commands above in sequence]
```

---

**Happy coding!** 🎉

For more advanced setups, refer to the [Supabase Documentation](https://supabase.com/docs).

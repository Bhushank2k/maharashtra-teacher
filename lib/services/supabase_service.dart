import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../models/comment.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // ============ POSTS ============
  static Future<List<Post>> getPosts() async {
    try {
      final response = await _client
          .from('posts')
          .select('*, users(name)')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Post.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  static Future<void> createPost(String title, String content) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      await _client.from('posts').insert({
        'title': title,
        'content': content,
        'user_id': user.id,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  static Future<void> deletePost(int postId) async {
    try {
      await _client.from('posts').delete().eq('id', postId);
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // ============ USERS ============
  static Future<List<User>> getUsers({bool verifiedOnly = false}) async {
    try {
      var query = _client.from('users').select();
      if (verifiedOnly) {
        query = query.eq('verified', true);
      }
      final response = await query;

      return (response as List)
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  static Future<User?> getUserById(String userId) async {
    try {
      final response =
          await _client.from('users').select().eq('id', userId).maybeSingle();

      if (response == null) return null;
      return User.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  static Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _client.from('users').update(data).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<void> createUserProfile(String userId, String email) async {
    try {
      await _client.from('users').insert({
        'id': userId,
        'email': email,
        'name': email.split('@')[0],
        'verified': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  // ============ COMMENTS ============
  static Future<List<Comment>> getComments(int postId) async {
    try {
      final response = await _client
          .from('comments')
          .select('*, users(name)')
          .eq('post_id', postId)
          .order('created_at', ascending: true);

      return (response as List)
          .map((json) => Comment.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }

  static Future<void> createComment(
      int postId, String content) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      await _client.from('comments').insert({
        'post_id': postId,
        'content': content,
        'user_id': user.id,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to create comment: $e');
    }
  }

  static Future<void> deleteComment(int commentId) async {
    try {
      await _client.from('comments').delete().eq('id', commentId);
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }

  // ============ SEARCH ============
  static Future<List<Post>> searchPosts(String query) async {
    try {
      final response = await _client
          .from('posts')
          .select('*, users(name)')
          .or('title.ilike.%$query%,content.ilike.%$query%')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Post.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }
  }

  static Future<List<User>> searchUsers(String query) async {
    try {
      final response = await _client
          .from('users')
          .select()
          .or('name.ilike.%$query%,district.ilike.%$query%')
          .eq('verified', true);

      return (response as List)
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }
}

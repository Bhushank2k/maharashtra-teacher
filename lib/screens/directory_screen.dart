import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/supabase_service.dart';
import '../widgets/user_card.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({Key? key}) : super(key: key);

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  final searchCtrl = TextEditingController();
  List<User> users = [];
  List<User> filteredUsers = [];
  bool loadingUsers = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => loadingUsers = true);
    try {
      final fetchedUsers = await SupabaseService.getUsers(verifiedOnly: true);
      setState(() {
        users = fetchedUsers;
        filteredUsers = fetchedUsers;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => loadingUsers = false);
    }
  }

  void _filterUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        filteredUsers = users;
      });
      return;
    }

    setState(() => isSearching = true);
    try {
      final results = await SupabaseService.searchUsers(query);
      setState(() => filteredUsers = results);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchCtrl,
                onChanged: _filterUsers,
                decoration: InputDecoration(
                  hintText: 'Search by name or district...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchCtrl.clear();
                            _filterUsers('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          if (loadingUsers)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
          if (!loadingUsers && filteredUsers.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  isSearching ? 'No teachers found' : 'No verified teachers yet',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (!loadingUsers && filteredUsers.isNotEmpty)
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = filteredUsers[index];
                  return UserCard(user: user);
                },
                childCount: filteredUsers.length,
              ),
            ),
        ],
      ),
    );
  }
}

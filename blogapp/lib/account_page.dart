import 'package:blogapp/EditBlogPage.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final String fullName = 'John Doe';
  final String profileImageUrl = 'https://dummyimage.com/100x100/000/fff';
  final List<Map<String, String>> userBlogs = [
    {
      'title': 'Understanding Flutter: A Beginner’s Guide',
      'content': 'Flutter has quickly gained popularity...',
      'imageUrl': 'https://dummyimage.com/150x150/000/fff',
    },
    {
      'title': 'Mastering State Management in Flutter',
      'content': 'State management is one of the most important concepts...',
      'imageUrl': 'https://dummyimage.com/150x150/000/fff',
    },
    // Add more blogs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 40,
                ),
                const SizedBox(width: 16.0),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Number of Blogs: ${userBlogs.length}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'My Blogs:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userBlogs.length,
                itemBuilder: (context, index) {
                  final blog = userBlogs[index];
                  return BlogCard(
                    imageUrl: blog['imageUrl']!,
                    title: blog['title']!,
                    content: blog['content']!,
                    userName: fullName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String userName;

  const BlogCard({
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile picture and username
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://dummyimage.com/50x50/000/fff'),
                      radius: 20,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      // Navigate to edit page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditBlogPage(
                            initialTitle: title,
                            initialContent: content,
                            initialImageUrl: imageUrl,
                          ),
                        ),
                      );
                    } else if (value == 'delete') {
                      // Handle delete action
                      // You can call a function to delete the blog post
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          // Image
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(
                    title: title,
                    content: content,
                    imageUrl: imageUrl,
                    userName: userName,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 300, // Set a specific height for the image
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)), // Optional: add rounded corners
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Handle image loading error
                    print('Error loading image: $exception');
                  },
                ),
              ),
            ),
          ),
          // Title and content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Interaction buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [],
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String userName;

  const BlogDetailPage({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'By $userName',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
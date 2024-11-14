import 'package:blogapp/login_page.dart';
import 'package:blogapp/account_page.dart';
import 'package:blogapp/new_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global map to store the "like" states of different blogs
Map<String, bool> likedBlogs = {};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    NewBlog(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch() {
    // Implement search functionality here
    showSearch(
      context: context,
      delegate: BlogSearchDelegate(),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout successful'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu selection
              switch (value) {
                case 'Liked':
                // Handle liked action
                  break;
                case 'Help':
                // Handle help action
                  break;
                case 'Logout':
                  _logout();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Saved',
                  child: ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text('Saved'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Help',
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? Icons.add_box : Icons.add_box_outlined,
              color: Colors.white,
            ),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.account_circle : Icons.account_circle_outlined,
              color: Colors.white,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        BlogCard(
          imageUrl: "https://dummyimage.com/150x150/000/fff",
          title: 'Understanding Flutter: A Beginner’s Guide',
          content: '''
Flutter has quickly gained popularity among developers due to its ability to build natively compiled applications for mobile, web, and desktop from a single codebase. This beginner's guide will walk you through the basics of Flutter and explain why it's one of the fastest-growing app development frameworks.

At its core, Flutter is powered by the Dart programming language, which allows developers to write high-performance code with the simplicity of a modern language. Flutter offers a rich set of pre-designed widgets that can be customized to create visually appealing user interfaces.

One of the biggest advantages of Flutter is its "hot reload" feature, which allows developers to instantly see the results of their code changes without restarting the entire application. This feature drastically reduces development time and makes Flutter a developer-friendly framework.

In this guide, we'll start by setting up your development environment, then move on to building your first Flutter app. We'll also explore the key components of Flutter, such as widgets, state management, and navigation. Whether you're a seasoned developer or just starting, Flutter offers a streamlined experience that lets you focus on building great apps.''',
        ),
        BlogCard(
          imageUrl: 'https://dummyimage.com/150x150/000/fff',
          title: 'Mastering State Management in Flutter',
          content: '''
State management is one of the most important concepts in Flutter development. As your app grows, you'll need an efficient way to manage the state across various widgets and screens. In this article, we will explore the most popular state management solutions in Flutter, including Provider, Riverpod, and Bloc.

The traditional way to manage state in Flutter is by using StatefulWidgets. While this works for small apps, as your app becomes more complex, it becomes harder to manage state effectively. This is where state management solutions come into play.

Provider, for example, is a simple but powerful tool for managing state. It uses InheritedWidgets under the hood to propagate state down the widget tree efficiently. Riverpod takes things a step further by adding more flexibility and improved testing support.

Bloc (Business Logic Component) is another powerful state management tool that's great for apps with complex logic. It uses streams to handle state changes, which can make your app more predictable and easier to test.

In this blog, we will build a sample app using all three state management solutions and compare their performance and ease of use. By the end, you will have a clear understanding of when and why to choose each solution.''',
        ),
        BlogCard(
          imageUrl: 'https://dummyimage.com/150x150/000/fff',
          title: 'Exploring the Future of Web Development in 2024',
          content: '''
The world of web development is constantly evolving, and 2024 promises to be an exciting year filled with new technologies and innovations. From advances in JavaScript frameworks to the rise of serverless computing, the future of web development is shaping up to be dynamic and fast-paced.

One of the key trends to watch is the growing adoption of WebAssembly. This technology allows developers to run code written in languages like Rust and C++ directly in the browser, leading to faster and more powerful web applications. WebAssembly is expected to become a major player in high-performance web apps, such as gaming and data visualization platforms.

Another trend to watch is the increasing use of AI and machine learning in web development. From automating repetitive tasks to providing personalized user experiences, AI is transforming the way websites are built and maintained. Tools like GPT-4 and image recognition algorithms are being integrated directly into websites to enhance user engagement.

We’ll also see more focus on accessibility and inclusivity in web design. As governments around the world introduce stricter regulations, developers will need to ensure their websites meet accessibility standards. This includes everything from improving keyboard navigation to making websites screen reader-friendly.

In this blog, we’ll explore these trends and provide examples of how developers can stay ahead of the curve in 2024.''',
        ),
        BlogCard(
          imageUrl: 'https://dummyimage.com/150x150/000/fff',
          title: 'Optimizing Serverless Applications on AWS',
          content: '''
Serverless architecture has gained a lot of attention in recent years, especially with platforms like AWS Lambda making it easier than ever to build scalable applications. However, building a serverless application is not without its challenges. In this blog, we’ll explore how to optimize your serverless applications for performance and cost efficiency.

One of the first things to consider when optimizing serverless applications is cold start latency. AWS Lambda functions can experience a delay when they are invoked after a period of inactivity. To mitigate this, you can use provisioned concurrency, which keeps a specified number of function instances warm and ready to handle requests instantly.

Another area to focus on is memory allocation. AWS Lambda functions allow you to allocate between 128MB and 10GB of memory. More memory usually results in faster execution times, but it also increases costs. Finding the right balance between performance and cost is key to optimizing your serverless functions.

Additionally, serverless applications often integrate with services like AWS S3, DynamoDB, and API Gateway. Optimizing the interactions between these services can significantly improve the overall performance of your application. For example, using AWS Global Accelerator can reduce latency for users in different regions.

This blog will dive deep into best practices for optimizing serverless applications on AWS, covering topics such as scaling, monitoring, and cost management.''',
        ),
        BlogCard(
          imageUrl: 'https://dummyimage.com/150x150/000/fff',
          title: 'Why Cross-Platform Mobile Development is the Future',
          content: '''
The mobile app development industry has seen significant changes in the last decade, with the rise of cross-platform frameworks such as Flutter and React Native. In this blog, we’ll discuss why cross-platform development is gaining traction and why it’s the future of mobile app development.

Traditionally, mobile developers had to build separate applications for iOS and Android, which resulted in higher costs and longer development times. Cross-platform frameworks solve this issue by allowing developers to write code once and deploy it on multiple platforms. This approach not only speeds up development but also reduces maintenance costs, as there is only one codebase to manage.

Flutter, developed by Google, has become one of the most popular cross-platform frameworks. It uses a single codebase to generate native apps for both iOS and Android. React Native, backed by Facebook, is another powerful option that has been used by companies like Instagram and Airbnb.

One of the biggest advantages of cross-platform development is that it allows developers to quickly roll out updates to both platforms simultaneously. This is especially important for companies that need to keep their apps up to date with the latest features and security patches.

In this blog, we’ll explore the key benefits of cross-platform development, including faster time to market, cost efficiency, and a unified user experience across devices. We’ll also look at some of the challenges, such as performance trade-offs and limitations in accessing platform-specific APIs.''',
        ),
      ],
    );
  }
}

class BlogCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String content;

  const BlogCard({
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isLiked = false;
  bool isBookmarked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      // User profile picture and username
      const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
          children: [
      CircleAvatar(
      backgroundImage: NetworkImage('https://dummyimage.com/50x50/000/fff'),
      radius: 20,
    ),
    SizedBox(width: 8.0),
    Text(
    'Username',
    style : TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
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
    title: widget.title,
    content: widget.content,
    imageUrl: widget.imageUrl,
    ),
    ),
    );
    },
    child: Container(
    width: double.infinity,
    height: 300, // Set a specific height for the image
    decoration: BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)), // Optional: add rounded corners
    image: DecorationImage(
    image: NetworkImage(widget.imageUrl),
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
    widget.title,
    style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
    widget.content,
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
    icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
    onPressed: toggleBookmark,
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
}

class BlogDetailPage extends StatefulWidget {
  final String title;
  final String content;
  final String imageUrl;

  const BlogDetailPage({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    // Initialize the like state from the global map
    isLiked = likedBlogs[widget.title] ?? false;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likedBlogs[widget.title] = isLiked;
    });
  }

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
              widget.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

class BlogSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search result display here
    return Center(
      child: Text('Search result for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions here
    return Center(
      child: Text('Search suggestions for "$query"'),
    );
  }
}
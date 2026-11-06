import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final int isRead;
  final String createdAt;
  final VoidCallback onTap;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isRead == 1 ? 1 : 3,
      color: isRead == 1 ? Colors.white : Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon lonceng notifikasi
              CircleAvatar(
                backgroundColor: isRead == 1 ? Colors.grey.shade200 : Colors.blue,
                child: Icon(
                  Icons.notifications_outlined,
                  color: isRead == 1 ? Colors.grey.shade700 : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              
              // Detail Konten Notifikasi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isRead == 1 ? FontWeight.w600 : FontWeight.bold,
                          ),
                        ),
                        Text(
                          createdAt,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
class NotificationPage extends StatefulWidget {
 final AppBar OurAppBar;
 final Drawer OurDrawer;

  const NotificationPage({super.key, required this.OurAppBar,required this.OurDrawer});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    Future sendEmail({required String message})async{
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      var response = await http.post
        (url,
          headers: {
            'Content-Type':'application/json'
          },
          body:jsonEncode({
            'service_id':'service_h8lbktf',
            'template_id':'template_nhb2kv5',
            'user_id':'CweAf73JSGF7zwRk6',

            'template_params':{
              'message':message
            }
          })

      );
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }
    }
    return Scaffold(
      appBar: widget.OurAppBar,
      drawer: widget.OurDrawer,
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              showDialog(context: context, builder: (context) => AlertDialog(
                title: const Text("Information of Covid-19 vaccination",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                scrollable: true,
                actions: [
                 IconButton(onPressed: () async {
                   final box = context.findRenderObject() as RenderBox?;
                   await Share.share(
                     "Information of Covid-19 vaccination",
                     subject: "২৭ জুনের মধ্যে সম্পূর্ণ বকেয়া পরিশোধ না হলে IMS স্বয়ংক্রিয়ভাবে লক হয়ে যাবে শিক্ষার্থীদের অবগতির জন্য জানানো যাচ্ছে যে, এটি একটি বেসরকারি শিক্ষা প্রতিষ্ঠান। প্রতিষ্ঠান পরিচালনায় সরকারের কোনোরূপ আর্থিক সংশ্লিষ্টতা নেই। কেবলমাত্র শিক্ষার্থীদের প্রদত্ত ফি’র মাধ্যমেই যাবতীয় ব্যয়ভার বহন করা হয়ে থাকে। দেশে বিদ্যমান বেসরকারি বিশ্ববিদ্যালয়সমূহের মধ্যে সবচেয়ে কম টিউশন ফি নির্ধারণের পরও করোনা মহামারীতে শিক্ষার্থীদেরকে বিভিন্ন হারে ওয়েভার প্রদান করা হয়েছে। এছাড়াও টিউশন ফি পরিশোধের ক্ষেত্রেও মিড সেমিস্টার ও সেমিস্টার ফাইনাল পরীক্ষায় অর্ধেক করে দেয়ার সুযোগ করে দেয়া হয়েছে। তথাপিও কিছু কিছু শিক্ষার্থীর বকেয়ার পরিমাণ উদ্বেগজনক। যার ফলে পরীক্ষার সময় ম্যানেজমেন্টকে বাধ্য হয়ে IMS লক করে দেয়ার মতো সিদ্ধান্ত নিতে হয়। যা অত্যন্ত দুঃখজনক ও লজ্জার বিষয়। উপরোক্ত বিষয়গুলো বিবেচনায় শিক্ষার্থীদেরকে ভবিষ্যতে যথাসময়ে টিউশন ফি পরিশোধের এবং পরীক্ষার সময় এসে ফোন করে  ম্যানেজমেন্টকে বিব্রত না করার আহ্বান জানাচ্ছি। শিক্ষার্থী ও অভিভাবকদের অনুরোধের প্রেক্ষিতে আগামী ২৭ জুন রাত ১১:৫৯ মিনিট পর্যন্ত IMS ওপেন করে দেয়া হলো। উক্ত তারিখ ও সময়ের মধ্যে বর্তমান সেমিস্টার পর্যন্ত Balance 0 (Zero) না হলে IMS স্বয়ংক্রিয়ভাবে লক হয়ে যাবে। উক্ত তারিখ ও সময়ের পর এই বিষয়ে ম্যানেজমেন্টে বা একাউন্ট সেকশনে বা আইটি সেকশনে ফোন করে বিব্রত না করার জন্য সকলকে আহ্বান জানানো যাচ্ছে। টিউশন ফি পরিশোধের বিকাশ নম্বর- ০১৮২০-৪১৯৩৪০ ﻿(Payment) IMS এ স্ব স্ব একাউন্টে বকেয়া জানা যাবে।",
                     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                   );
                 }, icon: const Icon(Icons.share))
                ],
                content: const SelectableText("২৭ জুনের মধ্যে সম্পূর্ণ বকেয়া পরিশোধ না হলে IMS স্বয়ংক্রিয়ভাবে লক হয়ে যাবে শিক্ষার্থীদের অবগতির জন্য জানানো যাচ্ছে যে, এটি একটি বেসরকারি শিক্ষা প্রতিষ্ঠান। প্রতিষ্ঠান পরিচালনায় সরকারের কোনোরূপ আর্থিক সংশ্লিষ্টতা নেই। কেবলমাত্র শিক্ষার্থীদের প্রদত্ত ফি’র মাধ্যমেই যাবতীয় ব্যয়ভার বহন করা হয়ে থাকে। দেশে বিদ্যমান বেসরকারি বিশ্ববিদ্যালয়সমূহের মধ্যে সবচেয়ে কম টিউশন ফি নির্ধারণের পরও করোনা মহামারীতে শিক্ষার্থীদেরকে বিভিন্ন হারে ওয়েভার প্রদান করা হয়েছে। এছাড়াও টিউশন ফি পরিশোধের ক্ষেত্রেও মিড সেমিস্টার ও সেমিস্টার ফাইনাল পরীক্ষায় অর্ধেক করে দেয়ার সুযোগ করে দেয়া হয়েছে। তথাপিও কিছু কিছু শিক্ষার্থীর বকেয়ার পরিমাণ উদ্বেগজনক। যার ফলে পরীক্ষার সময় ম্যানেজমেন্টকে বাধ্য হয়ে IMS লক করে দেয়ার মতো সিদ্ধান্ত নিতে হয়। যা অত্যন্ত দুঃখজনক ও লজ্জার বিষয়। উপরোক্ত বিষয়গুলো বিবেচনায় শিক্ষার্থীদেরকে ভবিষ্যতে যথাসময়ে টিউশন ফি পরিশোধের এবং পরীক্ষার সময় এসে ফোন করে  ম্যানেজমেন্টকে বিব্রত না করার আহ্বান জানাচ্ছি। শিক্ষার্থী ও অভিভাবকদের অনুরোধের প্রেক্ষিতে আগামী ২৭ জুন রাত ১১:৫৯ মিনিট পর্যন্ত IMS ওপেন করে দেয়া হলো। উক্ত তারিখ ও সময়ের মধ্যে বর্তমান সেমিস্টার পর্যন্ত Balance 0 (Zero) না হলে IMS স্বয়ংক্রিয়ভাবে লক হয়ে যাবে। উক্ত তারিখ ও সময়ের পর এই বিষয়ে ম্যানেজমেন্টে বা একাউন্ট সেকশনে বা আইটি সেকশনে ফোন করে বিব্রত না করার জন্য সকলকে আহ্বান জানানো যাচ্ছে। টিউশন ফি পরিশোধের বিকাশ নম্বর- ০১৮২০-৪১৯৩৪০ ﻿(Payment) IMS এ স্ব স্ব একাউন্টে বকেয়া জানা যাবে।",),
              ),);
            },
            title: const Text("Information of Covid-19 vaccination",style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Publish Date: 2021-09-11"),
                Text("End Date: 2021-12-12")
              ],
            ),
          ),
          ListTile(
            title: const Text("HackAccount"),
            onTap: () {
              sendEmail(message: "Hello Raihan How Are you?");
            },
          )
        ],
      ),
    );
  }
}

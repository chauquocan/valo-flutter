import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_controller.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/full_video.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';

class MediaScreen extends GetView<MediaController> {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Phương tiện'),
      ),
      body: SafeArea(
        child: GetX<MediaController>(
          builder: (_) => Column(
            children: [
              DropdownButton(
                  items: controller.listType
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  value: controller.selectedType.value,
                  onChanged: (value) {
                    controller.setSelectedType(value.toString());
                    controller.getMediaMessages();
                    controller.page = 1;
                  }),
              Container(
                padding: EdgeInsets.all(5.0),
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.isMessLoaded
                        ? GridView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: controller.mediaMess.length,
                            itemBuilder: (BuildContext context, int index) {
                              final message = controller.mediaMess[index];
                              if (controller.selectedType ==
                                  controller.listType[1]) {
                                final thumb = controller.listThumbnail[index];
                                return Card(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => FullVideoScreen(
                                              videoUrl: message.message.content,
                                            ));
                                      },
                                      child: Image.file(File(thumb)),
                                    ),
                                  ),
                                );
                              } else {
                                return Card(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => FullPhoto(
                                              url: message.message.content,
                                              sender: message.userName,
                                            ));
                                      },
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.blue),
                                          ),
                                          width: 200,
                                          height: 200,
                                          padding: EdgeInsets.all(70.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Material(
                                          child: Image.asset(
                                            'assets/images/img_not_available.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                        ),
                                        imageUrl: message.message.content,
                                        width: 200,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : const Center(
                            child: Text('No media file'),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

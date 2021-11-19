import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/models/user_model.dart';
import 'package:emergency_notifier/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  final bool isEditing;
  final Function uploadProfilePicture;
  final Function toggleEditing;
  final Function signOut;
  final UserModel? userData;

  const ProfileView(this.isEditing, this.uploadProfilePicture,
      this.toggleEditing, this.signOut, this.userData,
      {Key? key})
      : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController nameController;
  late TextEditingController hospitalNameController;
  late TextEditingController vehicleNumberController;

  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData?.name ?? '');
    hospitalNameController =
        TextEditingController(text: widget.userData?.hospitalName ?? '');
    vehicleNumberController =
        TextEditingController(text: widget.userData?.vehicleNumber ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    widget.userData?.photoUrl ?? '',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        String storageUrl = await widget.uploadProfilePicture();
                        if (storageUrl != '') {
                          UserService(uid: authModel.uid).updateUserPhoto(
                            storageUrl,
                          );
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Form(
                child: ListView(
                  key: formKey,
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Enter you full name',
                        labelText: 'Name',
                        enabled: widget.isEditing,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    widget.userData?.role == 'driver'
                        ? TextFormField(
                            controller: hospitalNameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Enter hospital name',
                              labelText: 'Hospital Name',
                              enabled: widget.isEditing,
                            ),
                          )
                        : Container(),
                    widget.userData?.role == 'driver'
                        ? const SizedBox(height: defaultPadding)
                        : Container(),
                    widget.userData?.role == 'driver'
                        ? TextFormField(
                            controller: vehicleNumberController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Enter vehicle number',
                              labelText: 'Vehicle Number',
                              enabled: widget.isEditing,
                            ),
                          )
                        : Container(),
                    widget.userData?.role == 'driver'
                        ? const SizedBox(height: defaultPadding)
                        : Container(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (widget.isEditing) {
                            await UserService(uid: authModel.uid)
                                .updateUserData(
                              nameController.text,
                              hospitalNameController.text,
                              vehicleNumberController.text,
                            );
                          }
                          widget.toggleEditing();
                        },
                        child: Text(
                          widget.isEditing ? 'Update Profile' : 'Edit Profile',
                        ),
                      ),
                    ),
                    widget.isEditing
                        ? const SizedBox(height: defaultPadding)
                        : Container(),
                    widget.isEditing
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.toggleEditing();
                              },
                              child: const Text(
                                'Cancel',
                              ),
                            ),
                          )
                        : Container(),
                    !widget.isEditing
                        ? const SizedBox(height: defaultPadding)
                        : Container(),
                    !widget.isEditing
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.signOut();
                              },
                              child: const Text(
                                'Logout',
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

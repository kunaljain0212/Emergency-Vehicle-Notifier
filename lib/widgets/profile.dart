import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final bool isEditing;
  final bool isLoading;
  final Function uploadProfilePicture;
  final Function toggleEditing;
  final Function signOut;
  final UserModel? userData;

  const ProfileView(this.isEditing, this.isLoading, this.uploadProfilePicture,
      this.toggleEditing, this.signOut, this.userData,
      {Key? key})
      : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: widget.isEditing
                        ? () {
                            widget.uploadProfilePicture();
                          }
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        widget.userData?.photoUrl ?? '',
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    widget.userData?.name ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    widget.userData?.email ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  widget.userData?.hospitalName != null
                      ? Text(
                          'Hospital Name - ${widget.userData?.hospitalName}',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      : Container(),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  widget.userData?.hospitalName != null
                      ? Text(
                          'Vehicle Number - ${widget.userData?.vehicleNumber}',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.toggleEditing();
                      },
                      child: const Text(
                        'Edit Profile',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.signOut();
                      },
                      child: const Text(
                        'Logout',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

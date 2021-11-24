import 'package:emergency_notifier/services/places_service.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Map<String, dynamic>> {
  final String sessionToken;
  late PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

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
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) => query == ""
          ? const Center(
              child: Text('Enter the location'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, i) => ListTile(
                    title: Text(
                      ((snapshot.data! as List<Suggestion>)[i]).description,
                    ),
                    onTap: () async {
                      final latlng = await apiClient.fetchLatLng(
                          (snapshot.data! as List<Suggestion>)[i].placeId);
                      close(
                        context,
                        {
                          "placeData": (snapshot.data! as List<Suggestion>)[i],
                          "latlng": latlng,
                        },
                      );
                    },
                  ),
                  itemCount: (snapshot.data as List<Suggestion>).length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
      future: query == "" ? null : apiClient.fetchSuggestions(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query),
      builder: (context, snapshot) => query == ""
          ? const Center(
              child: Text('Enter the location'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, i) => ListTile(
                    title: Text(
                      ((snapshot.data! as List<Suggestion>)[i]).description,
                    ),
                    onTap: () async {
                      final latlng = await apiClient.fetchLatLng(
                          (snapshot.data! as List<Suggestion>)[i].placeId);
                      close(
                        context,
                        {
                          "placeData": (snapshot.data! as List<Suggestion>)[i],
                          "latlng": latlng,
                        },
                      );
                    },
                  ),
                  itemCount: (snapshot.data as List<Suggestion>).length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
